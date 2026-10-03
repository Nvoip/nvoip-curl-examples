"""Request-contract tests. curl is replaced with a recorder; no network or delivery."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

class V3Test(unittest.TestCase):
    def run_example(self, name, extra=None):
        with tempfile.TemporaryDirectory() as tmp:
            curl = Path(tmp) / 'curl'
            curl.write_text('#!/usr/bin/env python3\nimport json,sys\nprint(json.dumps(sys.argv[1:]))\n')
            curl.chmod(0o700)
            env = {'PATH': tmp + os.pathsep + os.environ['PATH'], 'NVOIP_ACCESS_TOKEN': 'synthetic',
                   'NVOIP_OAUTH_CLIENT_ID': 'client&á', 'NVOIP_OAUTH_CLIENT_SECRET': 'secret&+é'}
            env.update(extra or {})
            p = subprocess.run(['sh', str(ROOT / 'examples' / name)], env=env, capture_output=True, text=True, check=True)
            return json.loads(p.stdout)

    def test_token(self):
        args = self.run_example(
            'create-access-token.sh'
        )
        self.assertEqual(args[-1], 'https://api.nvoip.com.br/auth/oauth2/token')
        self.assertIn('--fail-with-body', args)
        self.assertIn('grant_type=client_credentials', args)
        form = dict(arg.split('=', 1) for arg in args if '=' in arg)
        self.assertEqual(form.get('client_secret'), 'secret&+é')
        self.assertNotIn('grant_type=password', args)
        self.assertGreaterEqual(args.count('--data-urlencode'), 3)

    def test_balance(self):
        args = self.run_example('get-balance.sh')
        self.assertEqual(args[-1], 'https://api.nvoip.com.br/v3/balance')
        self.assertIn('Authorization: Bearer synthetic', args)

    def test_check_otp(self):
        args = self.run_example('check-otp.sh', {'NVOIP_OTP_KEY': 'key&á', 'NVOIP_OTP_CODE': '001122'})
        self.assertIn('Authorization: Bearer synthetic', args)
        self.assertIn('key=key&á', args)
        self.assertEqual(args[-1], 'https://api.nvoip.com.br/v3/check/otp')
        self.assertIn('--get', args)

    def test_send_otp_contract(self):
        args = self.run_example('send-otp.sh', {'NVOIP_OTP_PHONE': '11999990000'})
        body = json.loads(args[args.index('--data-binary') + 1])
        self.assertEqual(body, {'phoneNumber': '11999990000', 'methods': {'sms': True}})
        self.assertIn('Authorization: Bearer synthetic', args)

    def test_missing_bearer_prevents_curl(self):
        with self.assertRaises(subprocess.CalledProcessError):
            self.run_example('check-otp.sh', {'NVOIP_ACCESS_TOKEN': '', 'NVOIP_OTP_KEY': 'key', 'NVOIP_OTP_CODE': '1'})

if __name__ == '__main__': unittest.main()
