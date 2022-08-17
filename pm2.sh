pm2 delete odk-api
yarn install
pm2 start "yarn start" --name odk-api
