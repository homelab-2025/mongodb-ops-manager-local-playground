# mongodb-ops-manager-local-playground

This guide provides instructions to set up a local playground environment for MongoDB Ops Manager using Ubuntu 24.04 on wsl2.

## Prerequisites

- [Windows Subsystem for Linux (WSL)](https://www.microsoft.com/store/productId/9P9TQF7MRM4R) installed on your Windows machine.
- [Ubuntu 24.04](https://apps.microsoft.com/detail/9nz3klhxdjp5?hl=fr-FR&gl=FR) installed via WSL.

## Getting Started

1. Install the necessary dependencies:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install wget gnupg curl lsb-release -y
```

2. Add the MongoDB repository:

```bash
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

echo "deb [signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
sudo apt update
```

3. Install MongoDB:

```bash
sudo apt install -y mongodb-org
```

4. Create a directory for Ops Manager data:

```bash
sudo mkdir -p /data/appdb
sudo chown -R $USER:$USER /data
```

5. Create or edit the configuration file for Ops Manager at `/etc/mongod.conf`:

```yaml
systemLog:
  destination: file
  path: "/data/appdb/mongodb.log"
  logAppend: true

storage:
  dbPath: "/data/appdb"
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1

processManagement:
  fork: true
  pidFilePath: /tmp/mongod.pid

net:
  bindIp: 127.0.0.1
  port: 27017

setParameter:
  enableLocalhostAuthBypass: false
```

6. Start the MongoDB service:

```bash
mongod -f /etc/mongod.conf
```

7. Download Ops Manager for Debian 11 / Ubuntu 22/04, 24.04 at the official MongoDB website:

https://www.mongodb.com/try/download/ops-manager

8. Install Ops Manager:

```bash
sudo dpkg -i mongodb-mms*.deb
sudo apt-get -f install -y
```

9. Check if it was installed correctly:

```bash
ll /opt/mongodb/mms/
ll /opt/mongodb/mms/conf/conf-mms.properties
```

10. Start Ops Manager:

```bash
sudo /opt/mongodb/mms/bin/mongodb-mms start
# or via service
sudo service mongodb-mms start
```

It may take a few minutes for the service to start and should look like this:

```bash
sudo /opt/mongodb/mms/bin/mongodb-mms start
Migrate Ops Manager data
   Running migrations...                                   [  OK  ]
Starting Ops Manager server
   Instance 0 starting........                             [  OK  ]
Starting pre-flight checks
Successfully finished pre-flight checks

Start Backup Daemon...                                     [  OK  ]
```

11. Access Ops Manager:

Open your web browser and navigate to `http://localhost:8080`. You should see the Ops Manager login page.

12. Create an admin user, fill all the forms and log in. (use localhost as hostname and use a gmail account to receive emails for example).

13. Install Agent:

To deploy an instance, you need to install the agent on your target machine (which can be the same WSL2 Ubuntu instance). This agent will communicate with the Ops Manager server and allow to Automate, Monitor, and Backup your MongoDB deployments.

Click on "Deployments" -> "Agents" -> "Download & Settings" -> "Select your operating system" and follow the instructions to install the automation agent.

14. Start the Automation Agent:

Finally, start the automation agent using the following command:

```bash
sudo /opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent -config /etc/mongodb-mms/automation-agent.config
# or via systemd
sudo systemctl start mongodb-mms-automation-agent
```