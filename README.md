# face_auto_render
face image 3d renderer by using machine learning

To Use this Pan_3DD

we require:
- google colab (with pro) (currently)
- windows
- vscode with `Remote Development` extension


# How to do
1. download [Cloudflare ](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/)
2. shift download file into `C:\Users\<local_user>\.ssh`, changing file name as `cloudflared.exe`
3. turn on vscode
4. `ctrl+shift+p` -> open ssh, select  `C:/User/<local_user>/.ssh/config`
5. paste & copy the below

```
Host *.trycloudflare.com
  HostName %h
  User root
  Port 22
  ProxyCommand <asboulte path of cloud flare> access ssh --hostname %h


if you follow above rightly, you just put `C:/User/<local_user>/.ssh/config` into <asboulte path of cloud flare>
```

In google colab, mount your drive which clone this repository and run cloudflare.ipynb 
6. you can see the image like below. Then, paste & copy into vscode `ctrl+shift+p: connect to a remote host`  
![Image](https://github.com/orgs/AI-Data-system-EH/projects/6/assets/94746273/9f262e94-6391-4fd5-af3c-7c638361cc52)

7.  select OS: Linux & press your password in .ipynb


# RESULT
![image](https://github.com/HwuanPage/face_auto_render/assets/94746273/dfed94ad-dfa4-4119-830c-55a833294cbe)


