<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="resources/js/sb-admin-2.min.js"></script>
<script src="resources/vendor/datatables/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
	crossorigin="anonymous">
  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
		href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
		rel="stylesheet" type='text/css'>

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
	body {
		font-family: 'M PLUS Rounded 1c', sans-serif;
		
	}
	
	button {
		font-family: 'M PLUS Rounded 1c', sans-serif;
		
	}
	
	 
	
	tr,td {
		text-align : center;
	}
	
	#textbox {
		text-align : center;
	}
	</style>
<script>
	$(function() {
		$('#spellCheck').on('click', spellCheck)
	});

	function spellCheck() {

		var appid = "dj00aiZpPUxWMGxiWWJETnRITCZzPWNvbnN1bWVyc2VjcmV0Jng9N2E-";
		var url = "https://jlp.yahooapis.jp/KouseiService/V1/kousei";
		var sentence = $('#cEditor').val();
		//alert(text);	
		var startPos;
		var length;

		$.ajax({

			method : 'post',
			url : url,
			data : {
				"appid" : appid,
				"sentence" : sentence
			},
			dataType : 'xml',
			success : output,
			error : function(resp) {
				alert(JSON.stringify(resp))

			}

		});
	}

	function output(resp) {
		var content = '<table class="table table-bordered" cellspacing="0" style="table-layout:fixed; font-size:12px ">';
		if (resp == "") {
			console.log("resp is null");
		}
		if (resp != "") {
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#93b2ec;"><i class="fas fa-angle-down"></i></p>';
			$.each(
							$(resp).find("ResultSet"),
							function(index, item) {
								if ($(this).find("Surface").text() == "") {
									content += '<tr style=" font-size:15px;"><td colspan="2">問題が見つかりませんでした。</td></tr>';
								} else {
									content += '<tr style="width:80px; text-align:center; color:black;"><td>指摘箇所</td>';
									content += '<td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; color:black;">言い換え例</td>';
									content += '</tr>';
									content +='<tr style="width:80px;"><td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap" >'+ $(this).find("Surface").text();
									content += '</td>';
									content +='<td class="original" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">'+$(this).find("ShitekiWord").text();
									content += '</td>';
									content +='</tr>';
								}
							});
		}
		content += '</table>';
		$('#resultWordCheck').html(content);
	}
</script>
</head>
<body>
	
   <p style="text-align : center; font-weight: bold; font-size:35px; color:#93b2ec;">文章校正</p>
   <div id = "textbox">
      <textarea id="cEditor" name="cEditor"
         style="width: 80%; height: 100px;" placeholder="文章校正するテキストを入力してください"></textarea>
      <br><br> <input type="button" class="btn btn-primary btn-sm"
         id="spellCheck" value="文章校正する" >
   </div>
   <br>
   <div id="resultWordCheck"></div>


</body>
</html>