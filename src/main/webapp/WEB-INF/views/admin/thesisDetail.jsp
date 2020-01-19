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

  <title>論文登録 PAGE</title>

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin.css" rel="stylesheet">
	 <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
		rel="stylesheet" type='text/css'>
	
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
</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">
    <a class="navbar-brand mr-1" style="font-size: 25px; color:white;"><i class="fas fa-book-reader"></i> 論文提出 現況</a>
    <div class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
    	<a href="../" style="font-size: 25px; color: white;"><i class="fas fa-home" style="color: white;"></i></a>
    </div>
  </nav>

  <div id="wrapper">
    <div id="content-wrapper">
      <div class="container-fluid">

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header" style="font-size: 25px;">
            <i class="fas fa-book-reader"></i>
				論文提出 現況</div>
          <div class="card-body">
           <div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<tr style="font-size: 30px;">
										<th colspan="2" style="text-align: left;">${ThesisTemp.thesisTitle}</th>
									</tr>
									<tr>
										<th style="width: 200px;">著者</th>
										<td>${ThesisTemp.teamName} </td>
									</tr>
									<tr>
										<th>発行日</th>
										<td>${ThesisTemp.thesistempdate}</td>
									</tr>
									<tr>
										<th>添付ファイル</th>
										<td>${ThesisTemp.thesisorgname}
										</td>
									</tr>
									<tr>
										<th>抄録</th>
										<td>${ThesisTemp.thesisAbstract}</td>
									</tr>
										<tr style="text-align: right;">
										<td colspan="2">
											<a class="btn btn-primary"
												href="insertThesisSubmit?seq_thesistemp=${ThesisTemp.seq_thesistemp}" role="button"> <i class="fas fa-file-upload"></i> 論文生成
											</a>
											<a class="btn btn-primary"
												href="insertThesis" role="button"> <i
													class="fas fa-undo-alt"></i> 戻る
											</a></td>
										</tr>
								</table>
							</div>
          </div>
          </div>
          </div>
      </div>    
    <!-- /.content-wrapper -->
  </div>
  <!-- /#wrapper -->

</body>

</html>