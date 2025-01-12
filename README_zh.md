# 在 Termux 中安装 android\_nas

## 一、简介

本指南将指导你完成使用 Termux、CloudFlare Tunnel 和 Alist 在安卓设备上安装和设置 NAS（网络附加存储）系统的过程。这种组合使你能够创建一个私人且可远程访问的存储空间。

## 二、前提条件

**安装 Termux**：从安卓应用商店下载并安装 Termux 应用程序。Termux 在安卓系统上提供了类似 Linux 的环境，允许执行各种基于 Linux 的命令和软件。

**网络连接**：确保你的安卓设备有稳定的网络连接，可以是 Wi - Fi 或移动数据。

**Cloudflared 账户**：

在 Cloudflare 网站上创建一个账户。此账户对于使用 Cloudflare Tunnel 服务至关重要。你可以通过提供有效的电子邮件地址并设置密码来注册。

创建账户后，务必验证你的电子邮件地址。这一步很重要，因为某些高级操作可能需要验证，并且有助于确保账户的安全性。

**域名及在 Cloudflare 上的托管**：

你需要拥有一个域名。可以是你已经拥有的域名，也可以通过域名注册商注册一个新的域名。一些域名注册商可能会在特定时期提供免费或低成本的域名。

拥有域名后，你需要将其 DNS（域名系统）设置指向 Cloudflare。这个过程称为在 Cloudflare 上托管域名。登录到你的 Cloudflare 账户，在仪表板中添加你的域名。然后，按照 Cloudflare 提供的说明更新你的域名的 DNS 记录。这将确保当有人尝试访问你的域名时，请求会通过 Cloudflare 的服务器进行路由。

**Tunnel Token**：

创建 Cloudflared 账户并在 Cloudflare 上设置好你的域名后，你可以获取 tunnel token。登录到你的 Cloudflare 账户，导航到 Cloudflare Tunnel 的相关部分（通常在仪表板或特定服务区域下）。在那里，你会找到生成或查看 tunnel token 的选项。

tunnel token 对于在你的本地设备和 Cloudflare Tunnel 服务之间建立连接至关重要。它就像一把安全钥匙，确保只有授权设备才能使用隧道从公共网络访问你的本地服务。

## 三、安装步骤

### 步骤 1：更新和升级软件包

打开 Termux 应用程序。然后，更新现有软件包并将其升级到最新版本。执行以下命令：



```
termux-change-repo # 切换源
termux-setup-storage # 申请获取系统文件权限
pkg update && pkg upgrade && pkg install git
```

此命令将更新软件包索引，升级所有已安装的软件包，并安装`git`工具，这是后续步骤所必需的。

### 步骤 2：克隆本仓库
### 步骤 3：进入克隆的目录
### 步骤 4：赋予执行权限
### 步骤 5：部署脚本

连续命令为

```
git clone https://kkgithub.com/kmbase/android_nas_noroot && cd android_nas_noroot && chmod +x android_nas_noroot@kmbase.sh && ./android_nas_noroot@kmbase.sh
```

在脚本执行过程中，它将引导你完成一系列配置。它会提示你输入从 Cloudflare 网站获取的`tunnel - token`。此外，你还将被要求为 Alist 设置密码，该密码用于访问 Alist 管理界面。请确保设置一个强密码且易于记忆。

## 四、理解整体流程

成功完成上述步骤后，你就已经为使用 Termux、CloudFlare Tunnel 和 Alist 在安卓设备上构建 NAS 系统奠定了基础。

**Termux**：在安卓系统上提供了类似 Linux 的环境，允许执行各种基于 Linux 的命令和软件。

**CloudFlare Tunnel**：通过提供一种安全的方式，使你在安卓设备上托管的本地服务能够从公共网络访问，突破了网络限制。tunnel token 以及在 Cloudflare 上对你的域名的正确配置在这个连接中起着关键作用。

**Alist**：作为一个强大的存储管理工具，允许你轻松管理文件，包括上传、下载和目录操作。

## 五、安装后注意事项

### 1. 服务管理

**启动服务**：如果服务未按预期自动启动，你可以手动启动它们。

对于 CloudFlare Tunnel：`nohup cloudflared tunnel --no - autoupdate run [tunnel - token] &`

对于 Alist：`nohup alist admin set [alist_password]; nohup alist server --port 5244 &`

对于 aria2：`nohup aria2c --enable - rpc --rpc - allow - origin - all &`

**检查服务状态**：要检查服务的运行状态，可以使用以下命令：

对于 CloudFlare Tunnel：`pgrep -x "cloudflared"`

对于 Alist：`pgrep -x "alist"`

对于 aria2：`pgrep -x "aria2"`

**停止服务**：如果你想停止某个服务，可以使用`pkill -x`加上服务名称。例如，`pkill -x cloudflared`停止 CloudFlare Tunnel。

### 2. 访问 NAS

**访问 Alist 管理界面**：打开浏览器（可以是安卓设备上的默认浏览器或任何其他安装的浏览器），输入`https://[CloudFlare Tunnel分配的域名]:5244`。然后输入你在安装过程中为 Alist 设置的密码。

**使用 NAS 功能**：登录后，你可以开始使用 NAS 功能。

**上传文件**：点击上传按钮，选择本地文件或文件夹。

**下载文件**：选择你想要的文件，然后点击下载按钮。

**目录管理**：你可以执行诸如创建新文件夹、重命名、删除或移动现有文件夹等操作。

### 3. 参考文献
**安卓后台限制**：安卓设备为了节省电量和资源，可能会对后台运行的应用进行限制。这可能导致 Termux 中的服务在后台运行一段时间后被关闭。用户可以参考[解除安卓限制](https://cloud-atlas.readthedocs.io/zh-cn/latest/android/apps/android_12_background_limit_termux.html)文档进行相关设置，确保服务能够持续稳定运行。

**termux 守护进程**：关于 termux 守护进程的更多信息和设置方法，可查看[termux 守护进程](https://blog.csdn.net/YiBYiH/article/details/127294017)。合理设置守护进程可以保证 Termux 在后台正常运行。

**Alist 使用方法**：详细了解 Alist 的各种功能和使用方法，请参考[alist 官方文档](https://alist.nn.ci/zh/guide/install/manual.html#获取-alist)。官方文档中包含了丰富的操作指南和常见问题解答。

**CloudFlare Tunnel 设置**：关于 CloudFlare Tunnel 的更多高级设置和群晖相关的应用案例，可参考[群晖 tunnel](https://jimizhou.com/cloudflare-tunnel)。这些信息有助于用户更好地利用 CloudFlare Tunnel 的功能。

### 4. 法律和安全注意事项

**法律合规**：确保你使用此 NAS 系统符合所有相关法律法规。不要将其用于非法活动，如存储或共享盗版内容、侵犯隐私或任何其他非法行为。

**安全**：尽管 CloudFlare Tunnel 提供了一定程度的安全性，但保持系统和密码的安全仍然很重要。避免使用容易猜到的密码，并留意与你的 NAS 访问相关的任何异常活动。同时，保护好你的 Cloudflare 账户凭证和 tunnel token，因为它们是你 NAS 设置安全的关键。