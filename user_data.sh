#!/bin/bash
sudo yum update -y
sudo yum install nodejs -y

sudo cat > /get_ip.js << __EOF__
const script = 'TOKEN=\`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"\` && curl -H "X-aws-ec2-metadata-token: \$TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4'
const fs = require('node:fs');
const util = require('util');
const exec = util.promisify(require('child_process').exec);

async function fn() {
  try {
    const { stdout, stderr } = await exec(script);
    private_ip = stdout;
    console.log('stdout:', stdout);
    fs.writeFile("/private_ip.txt", stdout,
            function(err) {
                if(err) {
                        return console.log(err);
                }
         console.log("The file was saved!");
        });
  } catch (e) {
    console.error(e);
  }
}
fn();
__EOF__

sudo chmod 600 /get_ip.js
sudo node /get_ip.js

sudo cat > /server.js << __EOF__
const { createServer } = require('node:http');
const fs = require('fs');

const port = 80

const server = createServer((req, res) => {
  fs.readFile(\`/private_ip.txt\`, function(err, ip_address){
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/html');
      res.end(
        \`<html><head><title>TF-Deployed App</title></head>
            <body>
                <h1>The app is live!</h1>
                The local IP address for this instance is \${ip_address}
            </body>
        </html>\`
       )
    });
});

server.listen(port, () => {
  console.log(\`Server running on port \${port}\`);
});
__EOF__

sudo chmod 600 /server.js
sudo node /server.js
