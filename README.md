# nvoip-curl-examples

[![Nvoip](https://img.shields.io/badge/Nvoip-site-00A3E0?style=flat-square)](https://www.nvoip.com.br/) [![API v3](https://img.shields.io/badge/API-v3-1F6FEB?style=flat-square)](https://www.nvoip.com.br/api/) [![Docs](https://img.shields.io/badge/docs-OpenAPI-6A737D?style=flat-square)](https://github.com/Nvoip/nvoip-api-v3/blob/main/docs/openapi/README.md) [![Postman](https://img.shields.io/badge/Postman-workspace-FF6C37?style=flat-square)](https://nvoip-api.postman.co/workspace/e671d01f-168a-4c38-8d0e-c217229dd61a/team-quickstart) [![Stack](https://img.shields.io/badge/stack-cURL-073551?style=flat-square)](https://github.com/Nvoip/nvoip-api-examples) [![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue?style=flat-square)](LICENSE)

Exemplos oficiais da [Nvoip](https://www.nvoip.com.br/) em `curl` para OAuth, chamadas, OTP, WhatsApp, SMS e saldo na API v3.

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
- [Documentação da API](https://github.com/Nvoip/nvoip-api-v3/blob/main/docs/openapi/README.md)
- [Página da API](https://www.nvoip.com.br/api/)
- [Workspace Postman](https://nvoip-api.postman.co/workspace/e671d01f-168a-4c38-8d0e-c217229dd61a/team-quickstart)
- [Hub de exemplos](https://github.com/Nvoip/nvoip-api-examples)

## Migração para a v3

A URL base é `https://api.nvoip.com.br/v3`. Emita o token no backend em `https://api.nvoip.com.br/auth/oauth2/token`, com formulário `grant_type=client_credentials`, `client_id` e `client_secret`, e use `Authorization: Bearer`. O token do usuário e a napikey antigos não autenticam a v3. `client_credentials` pode não emitir refresh token; renove pela mesma emissão quando expirar. A chave com escopos depende do NN-5543 e não é apresentada como disponível aqui.

[Guia de migração v2 → v3](https://github.com/Nvoip/nvoip-api-examples/blob/main/docs/migration-v2-v3.md).

## Contrato de envio

O exemplo OTP usa `NVOIP_OTP_PHONE`, enviado em `phoneNumber` com `methods.sms=true`. A validação de código usa o mesmo Bearer da conta. O exemplo `send-sms.sh` de texto livre exige liberação explícita da política de SMS da v3; prefira um template `ACTIVE` da própria conta.

Validação offline: `python3 -m unittest discover -s tests`. Nenhuma requisição real é enviada nos testes.
