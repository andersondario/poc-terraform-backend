const middy = require('middy')
const { cors } = require('middy/middlewares')

async function helloMessage(event) {
    const { message } = JSON.parse(event.body);

    const response = {
        statusCode: 200,
        body: JSON.stringify({ message }),
    };

    return response;
};

module.exports.handle = middy(helloMessage).use(cors());