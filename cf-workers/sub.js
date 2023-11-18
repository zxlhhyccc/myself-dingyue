//部署完成后输入获得机场组合自建，https://sub.cf.workers.dev/?token=xxoo&user_tag=MuxData
//部署完成后输入，https://sub.cf.workers.dev/?token=xxoo&user_tag=''
// 默认节点信息
const MainData = `
ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpleGFtcGxlLmNvbQ@example1.com:443#example1
ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpleGFtcGxlLmNvbQ@example2.com:443#example2
`

addEventListener('fetch', event => { event.respondWith(handleRequest(event.request)) })


async function handleRequest(request) {
    const url = new URL(request.url);
    const url_tag = url.searchParams.get('user_tag');
    const token = url.searchParams.get('token'); // Get the token from the URL
  
    if (token !== 'xxoo') {//改为自己的token，可用uuid，https://1024tools.com/uuid
      await sendMessage("#InvalidToken info", request.headers.get('CF-Connecting-IP'), `Invalid Token: ${token}`);
      return new Response('Invalid token', { status: 403 });
    }
  
    let req_data = "";
  
    if (url_tag) {
        switch (url_tag) {
          case 'MuxData':
            const urls = [
              'https://mareep.netlify.app/sub/shadowrocket_base64.txt',
              'https://mareep.netlify.app/sub/shadowrocket_base64.txt'
              // 添加更多订阅,支持base64
            ];
    
            const responses = await Promise.all(urls.map(url => fetch(url)));
    
            for (const response of responses) {
              if (response.ok) {
                const content = await response.text();
                req_data += atob(content);
              }
            }
            req_data += MainData
            break;
    
          default:
            req_data = MainData;
            break;
      }
    } else {// 如果未找到 user_tag 参数，则随机生成一些无意义数据
      const bytes = new Uint8Array(Math.floor(Math.random() * 100));
      crypto.getRandomValues(bytes);
      req_data = String.fromCharCode.apply(null, bytes);
    }
  
    await sendMessage("#user info", request.headers.get('CF-Connecting-IP'), `User_Tag: ${url_tag}`);
    return new Response(btoa(req_data));
  }
  
//   # 创建自己的机器人和Token：

//   【1】添加好友 @BotFather
  
//   【2】输入【 /start 】 -【 /newbot 】，给新机器人自定义起名（可中文），必须以bot结尾，不能和别人重复
  
//   【3】起名新建成功后会输出Use this token to access the HTTP API，就是你这个机器人的Token,之后关注这个机器人
  
  
//   # UserID的获取：
  
//   【1】好友添加机器人 @userinfobot
  
//   【2】输入 /start ，即可获得自己的UserID。
  
  
//   # 或者 ChatID的获取【群组or频道】：
  
//   【1】群组or频道添加机器人 @get_id_bot
  
//   【2】输入 /my_id@get_id_bot ，即可获得-100开头的Chat ID : -1001818202301。

// 代码参考：https://azhuge233.com/cloudflare-workers-%E8%BD%AC%E5%8F%91-telegram-bot-%E6%8E%A8%E9%80%81%E4%BF%A1%E6%81%AF/
async function sendMessage(type, ip, add_data = "") {
  const OPT = {
    BotToken: '', // Telegram Bot API
    ChatID: '', // User 或者 ChatID，电报用户名
  }

  let msg = "";

  const response = await fetch(`http://ip-api.com/json/${ip}`);
  if (response.status == 200) { // 查询 IP 来源信息，使用方法参考：https://ip-api.com/docs/api:json
    const ipInfo = await response.json();
    msg = `${type}\nIP: ${ip}\nCountry: ${ipInfo.country}\nCity: ${ipInfo.city}\n${add_data}`;
  } else {
    msg = `${type}\nIP: ${ip}\n${add_data}`;
  }

  let url = "https://api.telegram.org/";
  url += "bot" + OPT.BotToken + "/sendMessage?";
  url += "chat_id=" + OPT.ChatID + "&";
  url += "text=" + encodeURIComponent(msg);

  return fetch(url, {
    method: 'get',
    headers: {
      'Accept': 'text/html,application/xhtml+xml,application/xml;',
      'Accept-Encoding': 'gzip, deflate, br',
      'User-Agent': 'Mozilla/5.0 Chrome/90.0.4430.72'
    }
  });
}