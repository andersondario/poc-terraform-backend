const middy = require('middy')
const { cors } = require('middy/middlewares')

async function helloWorld(event) {
    const response = {
        statusCode: 200,
        body: JSON.stringify({ message: "Hello World!" }),
    };

    return response;
};

module.exports.handle = middy(helloWorld).use(cors());