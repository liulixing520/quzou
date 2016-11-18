package com.baidu.yun;

import com.baidu.yun.channel.auth.ChannelKeyPair;
import com.baidu.yun.channel.client.BaiduChannelClient;
import com.baidu.yun.channel.exception.ChannelClientException;
import com.baidu.yun.channel.exception.ChannelServerException;
import com.baidu.yun.channel.model.PushUnicastMessageRequest;
import com.baidu.yun.channel.model.PushUnicastMessageResponse;
import com.baidu.yun.core.log.YunLogEvent;
import com.baidu.yun.core.log.YunLogHandler;

public class AndroidPushMessageSample {

    public static void PushMessage() {

        /*
         * @brief 推送单播消息(消息类型为透传，由开发方应用自己来解析消息内容) message_type = 0 (默认为0)
         */

        // 1. 设置developer平台的ApiKey/SecretKey
    	String apiKey = "fAcOr2gSiCpfRY6rjd6cuvnW";
        String secretKey = "dkoDeohqANoRqP1AIHn7BzrGS4FWTMPY";
        ChannelKeyPair pair = new ChannelKeyPair(apiKey, secretKey);

        // 2. 创建BaiduChannelClient对象实例
        BaiduChannelClient channelClient = new BaiduChannelClient(pair);

        // 3. 若要了解交互细节，请注册YunLogHandler类
        channelClient.setChannelLogHandler(new YunLogHandler() {
            @Override
            public void onHandle(YunLogEvent event) {
                System.out.println(event.getMessage());
            }
        });

        try {

            // 4. 创建请求类对象
            // 手机端的ChannelId， 手机端的UserId， 先用1111111111111代替，用户需替换为自己的
            PushUnicastMessageRequest request = new PushUnicastMessageRequest();
            request.setDeviceType(3); // device_type => 1: web 2: pc 3:android
                                      // 4:ios 5:wp
            //request.setChannelId(4549875271242017980L);
            request.setUserId("708105887597166687");

            request.setMessage("Hello Channel");
            // 若要通知，
            request.setMessageType(1);
            request.setMessage("{\"title\":\"你好啊\",\"description\":\"消息测试\"}");
            // 5. 调用pushMessage接口
            PushUnicastMessageResponse response = channelClient
                    .pushUnicastMessage(request);

            // 6. 认证推送成功
            System.out.println("push amount : " + response.getSuccessAmount());

        } catch (ChannelClientException e) {
            // 处理客户端错误异常
            e.printStackTrace();
        } catch (ChannelServerException e) {
            // 处理服务端错误异常
            System.out.println(String.format(
                    "request_id: %d, error_code: %d, error_message: %s",
                    e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
        }

    }
    public static void main(String[] args) {
    	PushMessage();
	}
}
