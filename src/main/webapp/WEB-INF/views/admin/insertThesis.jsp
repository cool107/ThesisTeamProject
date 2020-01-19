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
	<script>
		$(function(){
			selectThesisTemp();
		});
		
		function selectThesisTemp(){
			$.ajax({
				  method : 'POST'
				, url :  'selectThesisTemp'
				, success : function(resp) {
					outputThesisTemp(resp);
				}
			})
		}
		
		function outputThesisTemp(resp){
			var num = 1;
			var content = '<table class="table table-bordered" id="applicationTable" width="100%" cellspacing="0">';
				  content += '<tr><th style="width:80px;">番号</th><th>題目</th><th style="width:500px;">チームメンバー</th><th style="width:250px;">発行日</th></tr>';
			if(resp == ""){
				content += '<td colspan="6" style="text-align:center;">データがありません。</td>';
			} else if(resp != ""){
				$.each(resp, function(index, item){
					content += '<tr id="'+ item.seq_thesistemp +'">';
					content += '<td class="seq_thesistemp" style="text-align : center; vertical-align:middle;">'+num+'</td>';
					content += '<td class="thesisTitle" style="text-align : center; vertical-align:middle;"><a href="thesisDetail?seq_thesistemp='+ item.seq_thesistemp +'">' + item.thesisTitle + '</a></td>';
					content += '<td class="teamName" style="text-align : center; vertical-align:middle;">' + item.teamName + '</td>';
					content += '<td class="thesistempdate" style="text-align : center; vertical-align:middle;">' + item.thesistempdate + '</td>';
					content += '</tr>';
					num++;
				});
			}
			content += '</table>';
			$('#thesisData').html(content);
		}
	</script>
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
            <div class="table-responsive" id="thesisData">
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