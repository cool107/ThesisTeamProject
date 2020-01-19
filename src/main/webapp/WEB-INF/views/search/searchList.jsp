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

  <title>外方論文検索 Page</title>

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
	var onlysearch = [];
	$(function(){
		$('.searchRead').on('click', go_readforsearch)
		$('.gosearch').on('click', search);
	});
	
	function go_readforsearch() {
		var issn=$(this).attr('data-val');
		location.href = "search_read_only?issn="+issn;
	}
	
	function search(){
		var keyWord = $("#keyWord").val();
		var keyField = $("#keyField");
		var url='';
		if(keyField.val()=='searchByTitle'){
			url = "http://ci.nii.ac.jp/opensearch/search?format=rss&appid=r9VfS7vnAiyp0Tcn9OcS&q="+keyWord;	
		}else if(keyField.val()=='searchByAuthor'){
			url = "http://ci.nii.ac.jp/opensearch/search?format=rss&appid=r9VfS7vnAiyp0Tcn9OcS&author="+keyWord;
		}else if(keyField.val()=='searchByReferences'){
			url = "http://ci.nii.ac.jp/opensearch/search?format=rss&appid=r9VfS7vnAiyp0Tcn9OcS&references="+keyWord;
		}
		
		$.ajax(url, {
			accepts:{
				xml:"application/rss+xml"
			},
			dataType:"xml",
			success: function(resp) {
				$(resp).find("item").each(function () {
					var el = $(this);
					var title='';
					var description='';
					var issn='';
					var publishedDate='';
					var searchedAbstract='';
					var searchedTitle='';
					var link='';
					var author='';
					if(el.find("prism\\:issn").text()==''){
						return;
					}else{
					searchedTitle=el.find("title").text();
					searchedAbstract=el.find("description").text();
					issn=el.find("prism\\:issn").text();
					author=el.find("dc\\:creator").text();
					publishedDate=el.find("dc\\:date").text();
					link=el.find("link").text();
					var SearchedResult={
						"searchTitle" : keyWord,
						"searchedTitle": searchedTitle,
						"searchedAbstract" : searchedAbstract,
						"issn" : issn,
						"author": author,
						"publishedDate":publishedDate, 
						"link":link,								
						}
					}
					onlysearch.push(SearchedResult);
				});
				sendsearch(onlysearch);
			}	
		});
	}
	
	function sendsearch(onlysearch) {
		$.ajax({	
			method : 'post'			
			, url  : 'searchForm_first'
			, contentType : 'application/json; charset=utf-8'
			, data : JSON.stringify(onlysearch)						
			, success : function() {
				location.href = "searchList_form";
			}
			, error : function(resp) {
				console.log("error occured");
			}
		});
	}

</script>
</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-danger static-top" style="background-color: #e74a3b">
    <a class="navbar-brand mr-1" style="font-size: 25px; color:white;"><i class="fas fa-torah"></i> 外方論文検索</a>
		<ul class="navbar-nav ml-auto">
						<li class="nav-item dropdown no-arrow mx-1"><a href="../"
							style="font-size: 25px; color: white;"><i class="fas fa-home"
								style="color: white;"></i></a></li>
						<li style="padding-right: 10px;"></li>
						<li class="nav-item dropdown no-arrow"><span
							class="mr-2 d-none d-lg-inline text-gray-600 small"
							style="font-size: 20px; color:white;">${sessionScope.loginName} 様</span></li>
					</ul>
  </nav>

  <div id="wrapper">
    <div id="content-wrapper">
      <div class="container-fluid">

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header" style="font-size: 25px;">
        <div class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
					<div class="input-group">
					 <div class="form-group">
				      <select id="keyField" class="form-control">
				        <option value="searchByTitle" selected>題目</option>
						<option value="searchByAuthor">著者</option>
						<option value="searchByReferences">参考文献</option>
						
				      </select>
				      </div>
				      <div style="width:10px;"></div>
						<input type="text" class="form-control bg-light border-0 small"
							placeholder="Search for..." aria-label="Search"
							aria-describedby="basic-addon2" name="keyWord" id="keyWord">
						<div class="input-group-append">
							<button class="gosearch btn" style="background-color: #e74a3b">
								<i class="fas fa-search fa-sm" style="color: white;"></i>
							</button>
						</div>
					</div>
				</div></div>
          <div class="card-body">
            <div class="table-responsive" id="applicationData">
            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<tr>
						<th style="width:80%">論文文題</th>
						<th style="width:20%">著者</th>
					</tr>
						<c:forEach var="result" items="${onlysearch}" varStatus="status">
							<td style="color: blue;">
								<div class="searchRead" style="color: blue; cursor: pointer;" id="searchRead" data-val="${result.issn}">
								${result.searchedTitle}</a>
								</div>										
							</td>
							<td>
								<div id="author" data-val="${result.similarity}">
								${result.author}</a>
								</div>										
							</td>
						</tr>
					</c:forEach>
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