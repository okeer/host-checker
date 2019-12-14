# TCP connection checker

## Description

Simple full stack serverless application, hosted on GCP (static frontend on Google Storage, API backend on Cloud Functions).

The goal of this project - to get familiar with node.js and frontend stuff.

## Deployment

### FrontEnd

TBD

### Backend

1. Create a new service account on GCP according to [Serverless Docs](https://serverless.com/framework/docs/providers/google/guide/credentials/);
2. Compile the project:

```
# npm install
# npm run-script compile
```

3. Deploy the API backend to GCP:

```
# serverless deploy
```