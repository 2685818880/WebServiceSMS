var InterValObj; //timer����������ʱ��
var count = 120; //���������1��ִ��
var curCount;//��ǰʣ������
var code = ""; //��֤��
var codeLength = 6;//��֤�볤��

function sendMessage() {
	curCount = count;
	var jbPhone = $("#jbPhone").val();
	var jbPhoneTip = $("#jbPhoneTip").text();
	if (jbPhone != "") {
		if(jbPhoneTip == "�� ���ֻ��������ע�ᣬ������ȷ" || jbPhoneTip == "�� ������֤���ѷ��������ֻ�,�����"){
			// ������֤��
			for ( var i = 0; i < codeLength; i++) {
				code += parseInt(Math.random() * 9).toString();
			}
			// ����buttonЧ������ʼ��ʱ
			$("#btnSendCode").attr("disabled", "true");
			$("#btnSendCode").val("����" + curCount + "����������֤��");
			InterValObj = window.setInterval(SetRemainTime, 1000); // ������ʱ����1��ִ��һ��
			// ���̨���ʹ�������
			$.ajax({
				type: "POST", // ��POST��ʽ����
				dataType: "text", // ���ݸ�ʽ:JSON
				url: "UserAction_sms.action", // Ŀ���ַ
				data: "jbPhone=" + jbPhone +"&code=" + code,
				error: function (XMLHttpRequest, textStatus, errorThrown) { 
					
				},
				success: function (data){ 
					data = parseInt(data, 10);
					if(data == 1){
						$("#jbPhoneTip").html("<font color='#339933'>�� ������֤���ѷ��������ֻ�,�����</font>");
					}else if(data == 0){
						$("#jbPhoneTip").html("<font color='red'>�� ������֤�뷢��ʧ�ܣ������·���</font>");
					}else if(data == 2){
						$("#jbPhoneTip").html("<font color='red'>�� ���ֻ�������췢����֤�����</font>");
					}
				}
			});
		}
	}else{
		$("#jbPhoneTip").html("<font color='red'>�� �ֻ����벻��Ϊ��</font>");
	}
}

//timer������
function SetRemainTime() {
	if (curCount == 0) {                
		window.clearInterval(InterValObj);// ֹͣ��ʱ��
		$("#btnSendCode").removeAttr("disabled");// ���ð�ť
		$("#btnSendCode").val("���·�����֤��");
		code = ""; // �����֤�롣������������ʱ��������յ�����֤����Ȼ��Ч
	}else {
		curCount--;
		$("#btnSendCode").val("����" + curCount + "����������֤��");
	}
}

$(document).ready(function() {
	$("#SmsCheckCode").blur(function() {
		var SmsCheckCodeVal = $("#SmsCheckCode").val();
		// ���̨���ʹ�������
		$.ajax({
			url : "UserAction_checkCode.action", 
			data : {SmsCheckCode : SmsCheckCodeVal}, 
			type : "POST", 
			dataType : "text", 
			success : function(data) {
				data = parseInt(data, 10);
				if (data == 1) {
					$("#SmsCheckCodeTip").html("<font color='#339933'>�� ������֤����ȷ�������</font>");
				} else {
					$("#SmsCheckCodeTip").html("<font color='red'>�� ������֤���������ʵ��������д</font>");
				}
			}
		});
	});
});