<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>論文様式修正 PAGE</title>

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<style>
body {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

button {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

th {
	text-align: center;
}

</style>

<script src="resources/js/jquery-3.3.1.js"></script>
<script src="resources/ckeditor/ckeditor.js"></script>
<script>
		
		
		var editorConfig = {
				filebrowserUploadUrl : "/fileUpload",
				width : '100%',
				height : '470px'
			};

		$(function(){
			CKEDITOR.replace('updateThesis', editorConfig);
			$('.dropdown-item').on('click',(e) => {
				$('#dropdownMenu2').html('<i class="fas fa-school"></i> '+ e.target.value);
			});
			$('.dropdown-item').on('click',selectThesisForm);
			$('#updateThesisForm').on('click', updateThesisForm);
		});
		
		function selectThesisForm(value){
			var value = $(this).attr('data-val');
			$('#dropdownMenu2').removeAttr('data-val');
			$('#dropdownMenu2').attr('data-val', value);
			
			$.ajax({
				method : 'POST'
				, url : 'selectThesisForm'
				, data : {'department' : value}
				, success : function(resp){
					if (resp == "") {
						alert('該当する学科の論文様式がありません。');
						return;
					} else {
						CKEDITOR.instances.updateThesis.setData(resp.thesisForm);
					}
				}
			});
		};
		
		function updateThesisForm(){
			var thesisForm = CKEDITOR.instances.updateThesis.getData();
			var value = $('#dropdownMenu2').attr('data-val');
			$.ajax({
				method : 'POST'
				, url : 'updateThesisForm'
				, data : {'department' : value
							, 'thesisForm' : thesisForm}
				, success : function(resp) {
					if (resp == 1) {
						alert('修正に成功しました。');				
					} else {
						alert('修正失敗しました。もう一度やり直してください。');
						return;
					}
				}
			});
		};
	</script>
</head>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
		<a class="navbar-brand mr-1" style="font-size: 25px; color: white;">論文様式修正</a>
		<div
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<a href="../" style="font-size: 25px; color: white;"><i
				class="fas fa-home" style="color: white;"></i></a>
		</div>
	</nav>

	<div id="wrapper">
		<div id="content-wrapper">
			<div class="container-fluid">

				<!-- DataTables Example -->
				<div class="card mb-3" style="height: 850px;">
					<div class="card-header" style="font-size: 25px;">
						<i class="fas fa-table"></i> 論文様式修正
					</div>
					<div class="card-body">
						<div class="dropdown">
							<button class="btn btn-secondary dropdown-toggle" type="button"
								id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false" data-val="select"><i class="fas fa-school"></i> 学科</button>
							<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
								<button class="dropdown-item" type="button" value="医学系研究科" data-val="medical">医学系研究科</button>
								<button class="dropdown-item" type="button" value="教育学研究科" data-val="education">教育学研究科</button>
								<button class="dropdown-item" type="button" value="経済学研究科" data-val="economy">経済学研究科</button>
								<button class="dropdown-item" type="button" value="工学系研究科" data-val="engineering">工学系研究科</button>
								<button class="dropdown-item" type="button" value="情報理工学系研究科" data-val="information">情報理工学系研究科</button>
								<button class="dropdown-item" type="button" value="新領域創成科学研究科" data-val="frontier science">新領域創成科学研究科</button>
								<button class="dropdown-item" type="button" value="人文社会系研究科" data-val="humanities">人文社会系研究科</button>
								<button class="dropdown-item" type="button" value="数理科学研究科" data-val="mathematics">数理科学研究科</button>
								<button class="dropdown-item" type="button" value="総合文化研究科" data-val="culture">総合文化研究科</button>
								<button class="dropdown-item" type="button" value="農学生命科学研究科" data-val="agriculture">農学生命科学研究科</button>
								<button class="dropdown-item" type="button" value="法学政治学研究科" data-val="law">法学政治学研究科</button>
								<button class="dropdown-item" type="button" value="薬学系研究科" data-val="pharmacy">薬学系研究科</button>
								<button class="dropdown-item" type="button" value="理学系研究科" data-val="sciences">理学系研究科</button>
							</div>
						</div>
						<br>
						<textarea name="updateThesis" id="updateThesis">
						</textarea>
						<br>
						<div style="float: right;"><button type="button" class="btn btn-outline-dark" style="font-weight: bold;" id="updateThesisForm"><i class="fas fa-pencil-alt"></i> 修正する</button></div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.content-wrapper -->
	</div>
	<!-- /#wrapper -->
</body>
</html>