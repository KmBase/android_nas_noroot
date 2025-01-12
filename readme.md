**Read this in other languages: [English](README.md), [中文](README_zh.md).**
# Installation of android\_nas in Termux

## 一、Introduction

This guide will walk you through the process of installing and setting up a NAS (Network - Attached Storage) system on an Android device using Termux, CloudFlare Tunnel, and Alist. This combination allows you to create a private and remotely accessible storage space.

## 二、Prerequisites

**Install Termux**: Download and install the Termux application from the Android app store. Termux provides a Linux - like environment on Android, enabling the execution of various Linux - based commands and software.

**Internet Connection**: Ensure that your Android device has a stable internet connection, either via Wi - Fi or mobile data.

**Cloudflared Account**:

Create an account on the Cloudflare website. This account is essential for using Cloudflare Tunnel services. You can sign up by providing a valid email address and setting a password.

After creating the account, make sure to verify your email address. This step is important as it may be required for some advanced operations and to ensure the security of your account.

**Domain Name and Hosting on Cloudflare**:

You need to have a domain name. This can be a domain you already own or you can register a new one through a domain registrar. Some domain registrars may offer free or low - cost domain names for certain periods.

Once you have a domain name, you need to point its DNS (Domain Name System) settings to Cloudflare. This process is known as domain hosting on Cloudflare. Log in to your Cloudflare account, and in the dashboard, add your domain name. Then, follow the instructions provided by Cloudflare to update the DNS records of your domain. This will ensure that when someone tries to access your domain, the requests are routed through Cloudflare's servers.

**Tunnel Token**:

After creating a Cloudflared account and setting up your domain on Cloudflare, you can obtain the tunnel token. Log in to your Cloudflare account, navigate to the relevant section for Cloudflare Tunnel (usually in the dashboard or under a specific service area). There, you will find an option to generate or view the tunnel token.

The tunnel token is crucial for establishing the connection between your local device and the Cloudflare Tunnel service. It acts as a security key, ensuring that only authorized devices can use the tunnel to access your local services from the public network.

## 三、Installation Steps

### Step 1: Update and Upgrade Packages

Open the Termux application. Then, update existing packages and upgrade them to their latest versions. Execute the following command:



```
pkg update && pkg upgrade && pkg install git
```

This command updates the package index, upgrades all installed packages, and installs the `git` tool, which is required for the next steps.

### Step 2: Cloning This Repository


```
git clone https://github.com/kmbase/android_nas_noroot
```


### Step 3: Access the Cloned Directory

Navigate to the newly - cloned folder by running the following command:



```
cd android_nas_noroot
```

### Step 4: Execution Permissions

Make the relevant installation script executable by using the following command:



```
chmod +x android_nas_noroot@kmbase.sh
```

### Step 5: Deploying the Script

Execute the installation script with the following command:



```
./android_nas_noroot@kmbase.sh
```

During the script execution, it will guide you through a series of configurations. It will prompt you to input the `tunnel - token` which you obtained from the Cloudflare website. Additionally, you will be asked to set a password for Alist, which is used to access the Alist management interface. Make sure to set a strong and memorable password.

## 四、Understanding the Overall Process

After successfully completing the above steps, you have laid the foundation for building a NAS system on your Android device using Termux, CloudFlare Tunnel, and Alist.

**Termux**: Provides a Linux - like environment on Android, enabling the execution of various Linux - based commands and software.

**CloudFlare Tunnel**: Breaks through network limitations by providing a secure way for your local services (hosted on the Android device) to be accessible from the public network. The tunnel token and the proper configuration of your domain on Cloudflare play crucial roles in this connection.

**Alist**: Serves as a powerful storage management tool, allowing you to easily manage files, including uploading, downloading, and directory operations.

## 五、Post - installation Considerations

### 1. Service Management

**Starting Services**: If the services do not start automatically as expected, you can manually start them.

For CloudFlare Tunnel: `nohup cloudflared tunnel --no - autoupdate run [tunnel - token] &`

For Alist: `nohup alist admin set [alist_password]; nohup alist server --port 5244 &`

For aria2: `nohup aria2c --enable - rpc --rpc - allow - origin - all &`

**Checking Service Status**: To check the running status of the services, you can use the following commands:

For CloudFlare Tunnel: `pgrep -x "cloudflared"`

For Alist: `pgrep -x "alist"`

For aria2: `pgrep -x "aria2"`

**Stopping Services**: If you want to stop a service, you can use `pkill -x` followed by the service name. For example, `pkill -x cloudflared` to stop CloudFlare Tunnel.

### 2. Accessing the NAS

**Accessing the Alist Management Interface**: Open a browser (either the default browser on your Android device or any other installed browser) and enter `https://[CloudFlare Tunnel assigned domain name]:5244`. Then enter the password you set for Alist during the installation process.

**Using NAS Functions**: Once logged in, you can start using the NAS functions.

**Uploading Files**: Click the upload button and select the local files or folders.

**Downloading Files**: Select the files you want and click the download button.

**Directory Management**: You can perform operations such as creating new folders, renaming, deleting, or moving existing folders.

### 3. Reference
### 3. 参考文献
**android_12_background_limit_termux**：[android_12_background_limit_termux](https://cloud-atlas.readthedocs.io/zh-cn/latest/android/apps/android_12_background_limit_termux.html)文

**termux**：[termux daemon](https://blog.csdn.net/YiBYiH/article/details/127294017)

**Alist**：[alist](https://alist.nn.ci/zh/guide/install/manual.html#获取-alist)

**CloudFlare Tunnel**：[tunnel](https://jimizhou.com/cloudflare-tunnel)

### 4. Legal and Security Considerations

**Legal Compliance**: Ensure that you use this NAS system in compliance with all relevant laws and regulations. Do not use it for illegal activities such as storing or sharing pirated content, violating privacy, or any other illegal behavior.

**Security**: Although CloudFlare Tunnel provides a certain level of security, it is still important to keep your system and passwords secure. Avoid using easily - guessable passwords and keep an eye on any unusual activities related to your NAS access. Also, protect your Cloudflare account credentials and the tunnel token as they are key to the security of your NAS setup.