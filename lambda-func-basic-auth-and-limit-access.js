'use strict';
const AWS = require('aws-sdk');
const ssm = new AWS.SSM({ region: 'us-east-1' });

exports.lambda_handler = async (event, _, callback) => {
    console.log("event 1 :", event);
    console.log("event stringify", JSON.stringify(event));

    const paramsNames = {
        Names: [
            '/stg/BASIC_AUTH_USER_FE',
            '/stg/HTPASSWD_FE',
        ],
        WithDecryption: true
    };

    const BODY_CONTENT = `
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <title>403 Forbidden</title>
      </head>
      <body style="background-color:lightpink;">
        <h1>This is an Error Page</h1>
        <p>Your IP is not allowed to access this site!</p>
      </body>
    </html>`;

    const IP_LIST_HANOI = [
        "1.55.242.188",
        "116.97.243.74",
        "103.37.29.230",
        "42.112.114.236",
        "14.160.25.214",
        "42.116.7.14"
    ];

    const IP_LIST_DN = [
        "14.176.232.181",
        "118.69.176.252",
        "42.116.19.204"
    ];

    const IP_LIST_HCM = [
        "14.161.42.46",
        "118.69.186.112"
    ];

    const IP_LIST_TOKYO = [
        "150.249.248.10",
        "150.249.204.57"
    ];

    const IP_LIST_CUSTOMER = [
        "122.208.46.208",
        "203.181.12.233",
        "183.180.106.229",
        "165.76.254.241",
        "133.242.238.82",
        "34.67.66.236",
        "34.70.8.254",
        "122.221.48.58",
        "150.249.245.91",
        "124.35.138.34",
        "150.249.196.187",
        "122.208.46.210",
        "115.179.164.53",
        "115.179.164.54",
        "115.179.164.69",
        "115.179.164.70",
        "115.179.164.55",
        "115.179.164.71",
        "153.124.184.209"
    ];

    // Get request and request headers
    const request = event.Records[0].cf.request;
    const client_ip = request.clientIp;
    const headers = request.headers;

    console.log("headers :", headers);
    const ip_white_list = [...IP_LIST_HANOI, ...IP_LIST_DN, ...IP_LIST_HCM, ...IP_LIST_TOKYO, ...IP_LIST_CUSTOMER];

    if (ip_white_list.includes(client_ip)) {
        let authUser;
        let authPass;
        // Configure authentication- You can use it for your developers
        let data;

        try {
            data = await ssm.getParameters(paramsNames).promise();
        } catch (error) {
            callback(null, {
                statusCode: 500,
                body: JSON.stringify({
                    message: 'Error in getting paramters'
                })
            });
        }
        console.log("print data :", data);
        if (data && data.Parameters) {

            authUser = data.Parameters[0].Value;
            authPass = data.Parameters[1].Value;
            console.log(data.Paramters);
            console.log("user :", authUser);
            console.log("pass :", authPass);
        }

        // Construct the Basic Auth string
        const authString = 'Basic ' + Buffer.from(authUser + ':' + authPass).toString('base64');

        // Check wheter the requested resource is allowed or not
        let isAllowedResource = false;
        //Following part will unblock the .png,.svg and .jpg extensions on your cloudfront contained by S3 bucket
        if (request.uri === '/manifest.json') {
            isAllowedResource = true;
        } else if (/^\/.+(\.png|\.svg|\.jpg)$/.test(request.uri)) {
            isAllowedResource = true;
        }

        // Require Basic authentication
        if (!isAllowedResource && (typeof headers.authorization == 'undefined' || (headers.authorization[0].value != authString))) {
            const body = 'Unauthorized';
            const response = {
                status: '401',
                statusDescription: 'Unauthorized',
                body: body,
                headers: {
                    'www-authenticate': [{
                        key: 'WWW-Authenticate',
                        value: 'Basic'
                    }]
                },
            };
            callback(null, response);
        }

        // Continue request processing if authentication passed
        callback(null, request);
    }
    const response = {
        'status': '200',
        'statusDescription': 'Forbidden',
        'headers': {
            'cache-control': [
                {
                    'key': 'Cache-Control',
                    'value': 'max-age=0'
                }
            ],
            "content-type": [
                {
                    'key': 'Content-Type',
                    'value': 'text/html'
                }
            ],
            'content-encoding': [
                {
                    'key': 'Content-Encoding',
                    'value': 'UTF-8'
                }
            ]
        },
        'body': BODY_CONTENT
    };
    return response;
};
