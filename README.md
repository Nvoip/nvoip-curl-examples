# nvoip-curl-examples

[![Nvoip](https://img.shields.io/badge/Nvoip-site-00A3E0?style=flat-square)](https://www.nvoip.com.br/) [![API v2](https://img.shields.io/badge/API-v2-1F6FEB?style=flat-square)](https://www.nvoip.com.br/api/) [![Docs](https://img.shields.io/badge/docs-Apiary-6A737D?style=flat-square)](https://nvoip.docs.apiary.io/) [![Postman](https://img.shields.io/badge/Postman-workspace-FF6C37?style=flat-square)](https://nvoip-api.postman.co/workspace/e671d01f-168a-4c38-8d0e-c217229dd61a/team-quickstart) [![Stack](https://img.shields.io/badge/stack-cURL-073551?style=flat-square)](https://github.com/Nvoip/nvoip-api-examples) [![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue?style=flat-square)](LICENSE)

Exemplos oficiais da [Nvoip](https://www.nvoip.com.br/) em `curl` para OAuth, chamadas, OTP, WhatsApp, SMS e saldo na API v2.

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

### Destinatário WhatsApp

O exemplo mantém `NVOIP_WA_DESTINATION` para telefone. Para o contrato tipado,
use `NVOIP_WA_RECIPIENT_TYPE=phone|bsuid|parent_bsuid` e
`NVOIP_WA_RECIPIENT_VALUE`, sem `destination`. BSUID é opaco; não use
`@username` nem o coloque em campo de telefone. Exemplos mascarados:
`US.MASKED_BSUID_001` e `PARENT.MASKED_BSUID_001`.

## Observações

- este repositório é propositalmente enxuto e orientado a copy/paste
- para shell mais reutilizável e helpers prontos, use `nvoip-shell`
- para popup de telefone + código, use `nvoip-web-sdk`

## Links oficiais

- [Site da Nvoip](https://www.nvoip.com.br/)
- [Documentação da API](https://nvoip.docs.apiary.io/)
- [Página da API](https://www.nvoip.com.br/api/)
- [Workspace Postman](https://nvoip-api.postman.co/workspace/e671d01f-168a-4c38-8d0e-c217229dd61a/team-quickstart)
- [Hub de exemplos](https://github.com/Nvoip/nvoip-api-examples)
