# nvoip-curl-examples

Exemplos isolados em `curl` para os fluxos principais da API v2 da Nvoip.

## Objetivo

Este repositório é o ponto de entrada mais direto para quem quer:

- copiar e colar uma requisição pronta
- adaptar rapidamente em outra stack
- testar autenticação, ligações, OTP e WhatsApp sem instalar SDK

## Configuração

```bash
cp .env.example .env
```

Variáveis principais:

```bash
export NVOIP_NUMBERSIP="seu_numbersip"
export NVOIP_USER_TOKEN="seu_user_token"
export NVOIP_OAUTH_CLIENT_ID="seu_client_id"
export NVOIP_OAUTH_CLIENT_SECRET="seu_client_secret"
```

Se a sua operação já armazena o header serializado, você também pode usar:

```bash
export NVOIP_OAUTH_BASIC_AUTH="basic_auth_base64"
```

## Fluxos cobertos

- gerar `access_token`
- consultar saldo
- enviar SMS
- criar chamada
- enviar OTP
- validar OTP
- listar templates de WhatsApp
- enviar template de WhatsApp

## Exemplos

- `sh examples/create-access-token.sh`
- `sh examples/get-balance.sh`
- `sh examples/send-sms.sh`
- `sh examples/create-call.sh`
- `sh examples/send-otp.sh`
- `sh examples/check-otp.sh`
- `sh examples/list-whatsapp-templates.sh`
- `sh examples/send-whatsapp-template.sh`

## Observações

- este repositório é propositalmente enxuto e orientado a copy/paste
- para shell mais reutilizável e helpers prontos, use `nvoip-shell`
- para popup de telefone + código, use `nvoip-web-sdk`

## Documentação oficial

- https://nvoip.docs.apiary.io/
- https://www.nvoip.com.br/api
