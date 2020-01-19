<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>メッセージ Page</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin.css" rel="stylesheet">
	
	<link
		href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
		rel="stylesheet" type='text/css'>
	<style>
	body {
		font-family: 'M PLUS Rounded 1c', sans-serif;
	}
	
	input {
		font-family: 'M PLUS Rounded 1c', sans-serif;
	}
	
	a {
		color : green;
	}
	
	title {
		text-align: center;
	}
	</style>
 	<script src="resources/js/jquery-3.3.1.js"></script>
	<script>
		$(function(){
			oneMsg();
			
		});
		
		
		//메시지 1개만 출력
		function oneMsg() {
			var num = ${oneMsg};
			
			$.ajax({
				method : 'GET'
				, url : 'updateMessageCheck'
				, data : {"msg_seq" : num}
			});
			
			$.ajax({
				method : 'get'
				,url : 'getMsg'
				,data : {"msg_seq" : num}
				,success : function (resp) {
					outMsg(resp);
				}
				,error : function(resp) {
					console.log(resp);
				} 	
				
			});
			
		}
		
		function outMsg(resp) {
	
			var content = '<table class="table table-bordered" id="oneMsgTable" width="100%" cellspacing="0">';
			  content += '<tr><th style="font-size:18px;">'+resp.fromId+' 様から<br>受信時間'+resp.messageIndate+'</th></tr>';
			  content += '<tr><th style="font-size:20px;">'+resp.messageContent+'</th></tr>';	
			  content += '</table>';
			  content += '<div style="float:right;"><input type = "button" value = "返事" id = "respMsg" data-fromId = '+resp.fromId+' class="btn btn-outline-success" style="font-weight: bold;">&nbsp;';
			  content += '<a class="btn btn-outline-success" href="viewAllMessages" role="button" style="font-weight:bold;">戻る</a></div>';
				
			$('.card-body').html(content);
			$('#respMsg').on('click',respMsg);
		};
		
		//메시지 보내는 자식창으로
		function respMsg() {
			var fromId = $(this).attr("data-fromId");//TODO
			window.open('/popup','text','width=484, height=524, resizable = no, scrollbars = no');
			
		}
	
		
		function check(){
			var applicationSeq = $(this).attr("data-val");
			var msg_seq = $(this).attr("data-value");
			
			$.ajax({
				method : 'POST'
				, url : 'updateMemberCheck'
				, data : {'applicationSeq' : applicationSeq
							 ,'msg_seq' : msg_seq}
				, success : function(resp){
					if (resp == 0) {
						alert("失敗しました。");
						return;
					} else {
						allMessages();
					}
				}
			});
		};
		
		

	</script>
</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-success static-top">
    <a class="navbar-brand mr-1" style="font-size: 25px; color:white;"><i class="fas fa-dove"></i> メッセージ</a>
    <div class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
    	<a href="../" style="font-size: 25px; color:white;"><i class="fas fa-home"></i></a>
    </div>
  </nav>

  <div id="wrapper">
    <div id="content-wrapper">
      <div class="container-fluid">

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header" style="font-size: 25px;">
				<i class="fas fa-envelope-open-text"></i> メッセージ</div>
          <div class="card-body">
          	<input type = "button" value = "削除" id = "deleteMsg" class="btn btn-outline-success" style="font-weight: bold;">&nbsp;
          	<input type = "button" value = "新しいメッセージ" id="newMsg" class="btn btn-outline-success" style="font-weight: bold;">
          	<br>
          	<br>
            <div class="table-responsive" id="messagesData">
            </div>
          </div>
          </div>
          </div>
      </div>    
    <!-- /.content-wrapper -->
  </div>
  <!-- /#wrapper -->


	<script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
	<script src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js"/>"></script>
 	<script src="<c:url value="/resources/vendor/datatables/jquery.dataTables.js"/>"></script>
 	<script src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.js"/>"></script>
	<script src="<c:url value="/resources/js/sb-admin.min.js"/>"></script>

</body>

</html>