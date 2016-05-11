<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page import="cn.gov.csrc.base.action.FindAllData"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>中国证券会证券期货违法违规举报中心-注册</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/main.css">
<link
	href="<%=request.getContextPath()%>/formValidator1/style/validator.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
button {
	background: #F0F0F0 repeat-x;
	padding-top: 3px; 
	border-top : 1px solid #708090;
	border-right: 1px solid #708090;
	border-bottom: 1px solid #708090;
	border-left: 1px solid #708090;
	width: auto;
	line-height: 12pt; 
	font-size : 10pt;
	cursor: hand;
	font-size: 10pt;
	border-top: 1px solid #708090;
}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/formValidator1/formValidator-4.0.1.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/formValidator1/formValidatorRegex.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/register.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/sms.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function changeCheckNum() {
		var checkNumImage_ = document.getElementById("checkNumImage");
		checkNumImage_.src = "${pageContext.request.contextPath}/image.jsp?timeStamp="+ new Date().getTime();
	}
</script>
<script type="text/javascript">
	var msg = "${message}";
	if (msg != "") {
		alert(msg);
	}
</script>
</head>
<body>
	<%@include file="/statics/top.jspf"%>
	<div class="center_division">
		<div class="center_body">
			<div class="center_menu">
				<font color="#000000">当前位置：</font>
				<a href="<%=request.getContextPath()%>/statics/reg.jsp"><font color="#000000">用户注册</font></a>
			</div>
		</div>
		<div class="center_body_menu">
			<s:form action="RegisterAction_register" id="form1" name="form1" method="post" namespace="/">
				<table id="tb">
					<tr>
						<td colspan="3" align="center" bgcolor="#DDDFE1">举报人基本信息</td>
					</tr>
					<tr>
						<td align="center" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/new_reg_xing.gif"/>用户名：</td>
						<td align="center" width="40%">
							<s:textfield name="username" id="username" cssStyle="width:160px;height:24px;" onblur="checkusername()"/>
						</td>
						<td align="left" width="30%">
							<span id="usernameTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>username</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>登录密码：</td>
						<td align="center" width="40%">
							<s:password name="password" id="password" cssStyle="width:160px;height:24px;" onblur="checkpassword()"/>
						</td>
						<td align="left" width="30%">
							<span id="passwordTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>password</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>确认密码：</td>
						<td align="center" width="40%">
							<s:password name="passwordRepeat" id="passwordRepeat" cssStyle="width:160px;height:24px;" onblur="checkpasswrodb()"/>
						</td>
						<td align="left" width="30%">
							<span id="passwordRepeatTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>passwordRepeat</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
						<td align="center" width="40%">
							<s:textfield name="nickname" id="nickname" cssStyle="width:160px;height:24px;" onblur="checknickname()"/>
						</td>
						<td align="left" width="30%">
							<span id="nicknameTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>nickname</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
						<td align="center" width="40%">
							<s:radio list="#application.dataMap.get('10001')" name="jbSex" cssStyle="height:24px;"/>
						</td>
						<td align="left" width="30%"></td>
					</tr>
					<tr>
						<td align="center" width="30%">联系地址：</td>
						<td align="center" width="40%">
							<s:textfield name="jbAddress" id="jbAddress" cssStyle="width:160px;height:24px;" />
						</td>
						<td align="left" width="30%">
							<span id="jbAddressTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>jbAddress</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>联系手机：</td>
						<td align="center" width="40%">
							<s:textfield id="jbPhone" name="jbPhone" cssStyle="width:160px;height:24px;" onblur="checkjbPhone()"/>
						</td>
						<td align="left" width="30%">
							<span id="jbPhoneTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>jbPhone</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center"><img src="images/new_reg_xing.gif"/>短信验证码：</td>
						<td align="left" colspan="2" style="padding-left: 112px;">
							<s:textfield id="SmsCheckCode" name="SmsCheckCode" cssStyle="width:80px;height:24px;" maxLength="6" />
							<span><input type="button" id="btnSendCode" name="btnSendCode" value="免费获取验证码" onclick="sendMessage()" /></span>
							<span id="SmsCheckCodeTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>SmsCheckCodeTip</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>证件类型：</td>
						<td align="center" width="40%">
						<s:select list="#application.dataMap.get('10002')" label=""
								headerKey="" headerValue="--请选择--" value="1" listValue="value" onchange="enableCredentialsCode(this)"
								name="jbCredentialsName" id="jbCredentialsName" cssStyle="width:160px;height:24px;"/>
						</td>
						<td align="left" width="30%">
							<s:fielderror cssStyle="color:red;padding-left:10px;">
								<s:param>jbCredentialsName</s:param>
							</s:fielderror>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>证件号码：</td>
						<td align="center" width="40%">
							<s:textfield name="jbCredentialsCode" id="jbCredentialsCode" cssStyle="width:160px;height:24px;" onblur="checkjbCredentialsCode()"/>
						</td>
						<td align="left" width="30%">
							<span id="jbCredentialsCodeTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>jbCredentialsCode</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%">单位名称：</td>
						<td align="center" width="40%">
							<s:textfield name="jbCompanyName" id="jbCompanyName" cssStyle="width:160px;height:24px;" />
						</td>
						<td align="left" width="30%">
							<span id="jbCompanyNameTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>jbCompanyName</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%"><img src="images/new_reg_xing.gif"/>所在地区：</td>
						<td align="center" width="40%">
						<s:select list="#application.dataMap.get('10003')" label=""
								headerKey="" headerValue="--请选择--" listKey="key"
								cssStyle="width:160px;height:24px;" listValue="value" id="jbSourceArea"
								name="jbSourceArea" onblur="checkjbSourceArea()"/>
						</td>
						<td align="left" width="30%">
							<span id="jbSourceAreaTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>jbSourceArea</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td align="center" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/new_reg_xing.gif"/>验证码：</td>
						<td align="center" width="40%">
							<s:textfield id="checkNum" name="checkNum" cssStyle="width:60px;height:24px;" onblur="checkNumber()" maxLength="4"/>
							<img id="checkNumImage" src="${pageContext.request.contextPath}/image.jsp">
							<a onClick="changeCheckNum()" title="点击换一张" style="cursor:hand;">&nbsp;换一张</a>
						</td>
						<td align="left" width="30%">
							<span id="checkNumTip">
								<s:fielderror cssStyle="color:red;padding-left:10px;">
									<s:param>checkNumTip</s:param>
								</s:fielderror>
							</span>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="vertical-align: top; padding-top: 5px;padding-bottom: 5px;">
							<input type="submit" value="注册" style="width:50px; height:24px;"/>
							&nbsp;&nbsp;
							<input type="reset" value="重置" style="width:50px; height:24px;"/>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
	</div>
	<%@include file="/common/buttom.jspf"%>
</body>
</html>