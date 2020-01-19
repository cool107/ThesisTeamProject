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

  <title>メッセージ 送信 Page</title>

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
	</style>
	 <script src="resources/js/jquery-3.3.1.js"></script>
	<script>
 	$(function() {
		$("#toId").on('keyup', checkId);
 		$("#btn").on('click',goSubmit);
 	});
 	
 	function checkId(){
 		var id = $('#toId').val();
	 	$.ajax({
			method : 'GET'
			, url : 'checkId'
			, data : {'id' : id}
			, success : function(resp){
				if (resp == "") {
					$("#idCheckMsg").html("このIDは存在しません。IDを確認してください。").css('color', 'red');
					return;
				} else {
					$("#idCheckMsg").html("");
				}
			}
	 	});
 	}
 		function goSubmit() {
 			var id = $('#toId').val();
 			var messageContent = $('#messageContent').val();
 			if (id.length == 0 || messageContent.length == 0) {
 				alert("IDと内容を入力してください");
 				return false;
 			}

 			var data = {
 				"toId" : id,
 				"messageContent" : messageContent
 			};

 			$.ajax({
 				type : 'post'
 				,url : 'insertMsg'
 				,data : data
 				, success: function() {
 					console.log("success");
 					opener.location.reload();
 					window.close();
 				}
 				, error : function() {
 					console.log("error");
 				}
 			});
 			
 			

 		}
 

	</script>
	</head>
<body id="page-top">
	  <nav class="navbar navbar-expand navbar-dark bg-success static-top">
    <a class="navbar-brand mr-1" style="font-size: 25px; color:white;"><i class="fas fa-paper-plane"></i> 新しいメッセージ</a>
  </nav>
	<div style="padding: 18px;">
		受信者&nbsp;&nbsp;&nbsp;<input type="text" id="toId" placeholder="受信者のIDを入力"  style="width: 88%;"/> <br>
		<br>
		<div id="idCheckMsg" style="height: 15px;"></div>
		<br>
		<textarea rows="15" cols="60" name="messageContent" id="messageContent" placeholder="メッセージの内容を入力"></textarea>
		<br>
		<div style="text-align: right;"><br> <input type="button" class="btn btn-outline-success" value="メッセージ伝送" id = "btn"></div>
	</div>
	
		<script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
	<script src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js"/>"></script>
 	<script src="<c:url value="/resources/vendor/datatables/jquery.dataTables.js"/>"></script>
 	<script src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.js"/>"></script>
	<script src="<c:url value="/resources/js/sb-admin.min.js"/>"></script>
	</body>
	</html>