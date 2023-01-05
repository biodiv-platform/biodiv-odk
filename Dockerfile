# ca use lighter image for faster build
FROM  node:16 


# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN yarn install
COPY . .
RUN yarn build
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source


EXPOSE 3000
CMD [ "node", "dist/server.js" ]