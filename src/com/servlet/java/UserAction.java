package com.servlet.java;

public class UserAction {
	/**
	 * 验证手机短信是否发送成功
	 * 
	 * @throws Exception
	 */
	@Action(value = "UserAction_sms")
	public void sms() throws Exception {
		String result = "0";
		/** 手机号码 */
		String jbPhone = WebContextUtil.getRequest().getParameter("jbPhone");
		/** 短信验证码 */
		String code = WebContextUtil.getRequest().getParameter("code");
		/** 短信验证码存入session(session的默认失效时间30分钟) */
		WebContextUtil.getSession().setAttribute("code", code);
		/** 如何初始化失败返回 */
		if(!initClient()) {
			return;
		}
		/** 单个手机号发送短信的方法的参数准备 */
		// 手机号码
		String mobilephone = jbPhone;
		// 短信内容+随机生成的6位短信验证码
		String content = "根据中国证监会举报中心委托，特向您发送此条短信。您的注册验证码为:" + code;
		// 操作用户的ID
		Integer operId = Integer.parseInt(Env.getInstance().getProperty("operId"));
		// 定时发送的的发送时间(缺省为空，如果即时发送，填空)
		String tosend_time = "";
		// 应用系统的短信ID，用户查询该短信的状态报告(缺省为0，即不需查询短信的状态报告)
		int sms_id = 0;
		// 黑名单过滤(0：不需要黑名单过滤，1：需要黑名单过滤，缺省为0)
		short backlist_filter = 0;
		// 禁止语过滤(0：不需要禁止语过滤，1：需要禁止语过滤，缺省为0)
		short fbdword_filter = 0;
		// 优先级(值越大优先级越高，0：普通，1,：优先，2：最高，缺省为0)
		short priority = 0;
		// 短信有效时间(格式为：YYYY-MM-DD HH:mm:ss目前为空)
		String valid_time = "";
		/** 发送短信之前先统计一个已经发送的短信条数 */
		int messageCount = countService.findAllRecord(mobilephone);
		System.out.println("已发短信条数为：" +messageCount);
		if(messageCount < 5){
			/** 单个手机号发送短信 */
			if (!sendMessage(mobilephone, content, operId, tosend_time, sms_id,
					backlist_filter, fbdword_filter, priority, valid_time)) {
				result = "0";// 失败
			} else {
				result = "1";// 成功
				/** 发送一条短信，记录一条短信记录，为了方便之后的统计短信发送次数 */
				count.setPhone(mobilephone);// 手机号码
				count.setCaptcha(code);// 短信验证码
				count.setSendTime(CommonUtil.getNowDate());// 短信发送时间
				if(count != null){
					countService.saveEntity(count);
					System.out.println("保存成功!");
				}
			}
		}else{
			System.out.println("该手机号码今天发送验证码过多");
			result = "2";//一个手机号码最多发送3条短信验证码
		}
		HttpServletResponse response = WebContextUtil.getResponse();
		response.setContentType("application/json;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.write(result.toString());
	}
	
	/**
	 * WebService客户端初始化
	 * 
	 */
	public static boolean initClient() {
		/**
		 * 判断客户端是否已经初始化
		 */
		if (!SmsWebClient.enable()) {
			int ret = 0;
			try {
				ret = SmsWebClient.init(url, userName, passWord);
				if (ret == -1 || !SmsWebClient.enable()) {
					System.out.println("短信平台接口初始化失败！");
					return false;
				}
				System.out.println("短信平台接口初始化成功！"+ret+"----------");
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("短信平台接口初始化过程中异常！");
			}
		}
		return true;
	}
	
	/**
	 * 单个手机号码发送
	 * 
	 * @param mobilephone
	 *            手机号
	 * @param content
	 *            短信内容
	 * @param operId
	 *            操作用户的ID
	 * @param tosend_time
	 *            定时发送的发送时间
	 * @param sms_id
	 *            应用系统的短信ID
	 * @param backlist_filter
	 *            黑名单过滤
	 * @param fbdword_filter
	 *            禁止语过滤
	 * @param priority
	 *            优先级
	 * @param valid_time
	 *            短信有效时间
	 */
	public static boolean sendMessage(java.lang.String mobilephone,
			java.lang.String content, int operId, java.lang.String tosend_time,
			int sms_id, short backlist_filter, short fbdword_filter,
			short priority, java.lang.String valid_time) {
		// 单个手机号码发送
		try {
			SmsReturnObj retObj = SmsWebClient.webSendMessage(mobilephone,
					content, operId, tosend_time, sms_id, backlist_filter,
					fbdword_filter, priority, valid_time);
			if (retObj.getReturnCode() != 1) {
				System.out.println("短信发送失败，原因为：" + retObj.getReturnMsg());
				return false;
			} else {
				System.out.println("短信发送成功！返回结果为：" + retObj.getReturnMsg());
				return true;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("短信发送过程发生异常!");
		}
		return true;
	}
	
}
