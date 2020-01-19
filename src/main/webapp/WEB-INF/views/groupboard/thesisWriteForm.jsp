<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>チーム 掲示板</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:400,500,700&amp;subset=japanese"
	rel="stylesheet" type='text/css'>

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

button {
	font-family: 'M PLUS Rounded 1c', sans-serif;
}

.dropdown-content a:hover {
	background-color: #3C85C4;
	color: white;
}

.page-break {
	page-break-after: always;
	page-break-inside: avoid;
	clear: both;
}

.page-break-before {
	page-break-before: always;
	page-break-inside: avoid;
	clear: both;
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: white;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #4e73df;
	cursor: pointer;
	border: 1px solid #4e73df;
	border-bottom-color: #4e73df;
	border-radius: .25em;
}

.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

.badge-counter {
    position: absolute;
    -webkit-transform: scale(.7);
    transform: scale(.7);
    -webkit-transform-origin: top right;
    transform-origin: top right;
    right: -0.3rem;
    margin-top: -.25rem;
    background-color: red;
}
</style>
<script
	src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script>
	var templist = [];
	var count = 0;
	var listforsearch=[];
	//ckeditor 연결
	var editorConfig = {
		filebrowserUploadUrl : "/fileUpload",
		width : '100%',
		height : '600'
	};

	var ck = null;

	window.onload = function() {
		ck = CKEDITOR.replace("editor", editorConfig);

	};


	$(function() {
		selectMsgCount();
		$('#selectFiveMessages').on('click', selectFive).css('cursor', 'pointer');
    	$("#chatForm").on("click", goChatForm).css('cursor', 'pointer');
		$("#go_groupBoard").on('click', go_groupBoard);
		$("#similarityButton").on('click', similarity);
		$("#translate").on("click", translastion);
		$("#re").on('click', returnJap)
		$('#wordCheckButton').on('click', wordCheck);
		$('#generatePDF').on('click', savePDF);

		var fileTarget = $('.filebox .upload-hidden');
		fileTarget.on('change', function(){ 
			if(window.FileReader){ 
				var filename = $(this)[0].files[0].name; } else { 
					var filename = $(this).val().split('/').pop().split('\\').pop(); 
				} 
			$(this).siblings('.upload-name').val(filename);
		});
		
		$("#finalButton").on('click', finalSubmit)
	});
	
	function selectMsgCount(){
		var toId = '${sessionScope.loginId}';
		$.ajax({
			method : 'get'
			, url : 'selectMsgCount'
			, data : {'toId' : toId}
			, success : function(resp){
				$("#msgCount").text(resp);
			}
		})
	}
	
	function selectFive() {
	
		$.ajax({
			method : 'get',
			url : 'selectFiveMessages',
			success : outputMsg,
			error : function(resp) {
				console.log(resp);
			}
		});
	}

	function outputMsg(resp) {
		var content = '<table class="table table-bordered" id="msgTable" cellspacing="0" style="table-layout:fixed; font-size:12px;">';
		if (resp == "") {
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
			content += '<tr style="text-align:center; font-size:15px;"><td colspan="2">新しいメッセージがありません。</td></tr>';
		}
		if (resp != "") {
			content += '<p style="text-align:center; font-weight: bold; font-size:25px; color:#1cc88a;"><i class="fas fa-dove fa-lg" style="color:#1cc88a;"></i> ${sessionScope.loginName}様のメッセージ</p>';
			$
					.each(
							resp,
							function(index, item) {
								content += '<tr>';
								content += '<td class="fromId" style="width:80px; color:black;">'
										+ item.fromId + '</td>';
								content += '<td class="messageContent" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">'
										+ '<a href = "#" id = "getMessage">'
										+ item.messageContent
										+ '</a>'
										+ '</td>';
								content += '<td class="messageIndate" style="width:200px; color:black;">'
										+ item.messageIndate + '</td>';
								content += '</tr>';
							});
		}

		content += '</table>';
		$('.listOfMessage').html(content);
	};
	
	function sendsearch(listforsearch) {
		$.ajax({	
			method : 'post'			
			, url  : 'searhthesis'
			, contentType : 'application/json; charset=utf-8'
			, data : JSON.stringify(listforsearch)						
			, success : function() {
				location.href = "searhthesis_form";
			}
			, error : function(resp) {
				console.log("error occured");
			}
		});
	}
	
	function go_groupBoard() {
		location.href = "/groupboard_list";
	}

	function similarity(){
		var thesisTitle =$("#thesisTitle");
		var thesisAbstract = $("#thesisAbstract").val();
		if(thesisTitle.val()==''){
			alert("タイトルを入力しなければ検索されません。");
			thesisTitle.focus();
			thesisTitle.select();
			return;
		}
		if(thesisAbstract.length<10){
			alert("内容は10文字以上入力してください");
			thesisAbstract.focus();
			thesisAbstract.select();
			return;
		}
		search(thesisTitle, thesisAbstract);
		
	}
	
	//search for 유사도
	function search(thesisTitle, thesisAbstract){
		var search =thesisTitle
		var url = "http://ci.nii.ac.jp/opensearch/search?format=rss&appid=r9VfS7vnAiyp0Tcn9OcS&q="+search;
		
		$.ajax(url, {
			accepts:{
				xml:"application/rss+xml"
			},
			dataType:"xml",
			success: arraySimilar	
		});
	}
	
		function arraySimilar(resp) {
			var searchTitle =$("#thesisTitle");
			var searchAbstract = $("#thesisAbstract").val();
			test = $(resp).find("item");
				$(resp).find("item").each(function () {
					var el = $(this);
					var title='';
					var description='';
					var issn='';
					var publishedDate='';
					var link='';
					var author='';
					if(el.find("description").text()==''){
						return;
					}else{
						searchedTitle=el.find("title").text();
						searchedAbstract=el.find("description").text();
						issn=el.find("prism\\:issn").text();
						author=el.find("dc\\:creator").text();
						publishedDate=el.find("dc\\:date").text();
						console.log("here : " + el.find("dc\\:date").text());
						link=el.find("link").text();
						count=count+1;
						comparison(searchedTitle, searchedAbstract, issn, author, publishedDate, link, searchAbstract);
					}
				});
		}
		
			
		//유사도
		function comparison(searchedTitle, searchedAbstract, issn, author, publishedDate, link, searchAbstract){
				var searchTitle=$("#thesisTitle").val();
				var searchAbstract = $("#thesisAbstract").val();
				var searchedAbstract = searchedAbstract
				if(searchedAbstract==''){
					return;
				}
				
				var url = "https://labs.goo.ne.jp/api/textpair";
				var app_id = "07d830933e5c2bceceb8db1718f978c314675c1783b30e9ff7dc43ba38bce75d";
				var data = {
				  app_id        : app_id
				, text1         : searchAbstract
				, text2         : searchedAbstract
				}
				var obj = JSON.stringify(data);
				$.ajax({
					method : 'POST'			
					, url  : url
					, contentType: "application/json"	
					, data : obj						
					, success : function(resp) {
						var SearchedResult = {
								"searchTitle" : searchTitle,
								"searchedTitle": searchedTitle,
								"similarity" : resp.score,
								"searchedAbstract" : searchedAbstract,
								"searchAbstract":searchAbstract,
								"issn" : issn,
								"author": author,
								"publishedDate":publishedDate, 
								"link":link,
						}
						templist.push(SearchedResult);
						count=count-1;
						if(count==0){
						sendsimilar(templist);
						}
					}
					, error : function(resp) {
						console.log("error occured");
					}
				});
		}
	function sendsimilar(templist) {
		$.ajax({
			method : 'post',
			url : 'similarity',
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(templist),
			success : function() {
				location.href = "similarity_form";
			},
			error : function(resp) {
				console.log("error occured");
			}
		});
	}

	    //번역
		function translastion() {
				original = $("#thesisAbstract").val();
				var data = {
							q : original
							,target : 'en'
							,source : 'ja'
							,format: 'text' 	
							
				}
					var obj = JSON.stringify(data);
					console.log(data);
					var url='https://translation.googleapis.com/language/translate/v2?key=AIzaSyCaaYXwSPh2iD7r0XZdkWmu44vkJLAMq7w';
					$.ajax({
						method : 'post'			
						, url  : url
						, data : obj
						, contentType: "application/json"
						, success : function(resp) {
							console.log(JSON.stringify(resp));
							$("#translate").focus();
							$("#thesisAbstract").val(resp.data.translations[0].translatedText);
						}
						, error : function(resp) {
							console.log("error occured");
						}
					})
	    }
	    function returnJap(){
	    	if(original==''){
	    		alert("先に翻訳をした後,利用してください");
	    	}
	    	$("#thesisAbstract").val(original);
	    }
	    
	    function wordCheck() {
	    	var text = CKEDITOR.instances.editor.getData();
	    	var sentence = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
			
	    	//새 창에 대한 세팅(옵션)
	    	var settings = 'width=600, height=615, resizable = no, scrollbars = no';
	    	
	    	//자식창을 열고 자식창의 window객체를 openWin변수에 저장
	    	
				openWin = window.open('/wordCheck','childForm',settings);
			setTimeout(function(){
				openWin.document.getElementById('cEditor').value = sentence;
			}, 100);
	    	
			
	    
	    }
	
	function tempSave() {
		var thesisTitle = $('#thesisTitle').val();
		var department = $('#department').val();
		var thesisAbstract = $('#thesisAbstract').val();
		var degree = $('#degree').val();
		var editor = CKEDITOR.instances.editor.getData();
		
		if(thesisTitle=="") {
			alert("題目を入力してください。");
			return false;
		}
		
		$.ajax({
			method : 'post'
			,url : 'insertThesisTemp' 
			,data : {
				'thesisTitle' : thesisTitle
				,'thesisAbstract' : thesisAbstract
				,'editor' : editor
				,'department' : department
				,'degree' : degree
			}
			,success : function(resp) {
				if(resp==1) {
					alert("一時保存されました。");
				}
			}
			,error : function(resp) {
				console.log(resp)
			}
		});
	}
	
	function savePDF() {
			childWindow = window.open('','childWindow','location=yes, menubar=yes, toolbar=yes');
		    childWindow.document.open();
		    childWindow.document.write('<html><head></head><body>');
		    childWindow.document.write(document.getElementById('thesisAbstract').value.replace(/\n/gi,'<br>'));
		    childWindow.document.write(document.getElementById('editor').value.replace(/\n/gi,'<br>'));
		    childWindow.document.write('</body></html>');
		    childWindow.print();
		    childWindow.document.close();
		    childWindow.close();
	}
	
	function goChatForm() {
		window.open('/chatForm', 'text',
				'width=610, height=557, resizable = no, scrollbars = no');
	}
	
	function finalSubmit() {
		//파일 확장자가 pdf가 아니면 제출을 못하게 막는다.
		var fileName = $(ex_filename).val();
	    var filename; 
		var exp;
	    if(fileName.indexOf('.')>=0) {
	     filename = fileName.substring(0,fileName.lastIndexOf('.'));
	     exp = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
	    } else {
	     filename = fileName;
	     exp = '';
	    }
	    // 파일확장자 유무를 반환하여 확장자가 있으면 확장자를 소문자로 반환. 없으면 별도 메시지를 반환.
	    var expMsg = exp!='' ? exp.toLowerCase() : '選択フアイルに拡張子がありません。';
	    //alert('파일명 : '+filename+'\n'+'확장자 : '+expMsg);
		if(exp!="pdf") {
			alert("提出文書はPDFファイルのみです。");
			$(".upload-name").val("ファイル選択");
			return false;
		}
		
		$('#final').submit();
		
	}
	
	function selectThesisForm() {
		
		var fields = document.getElementById("department");
		var department = fields.options[fields.selectedIndex].value;
		
		$.ajax({
			method : "post"
			,url : "selectThesisForm"
			,data : {'department' : department}
			,success : function(resp) {
			
				 CKEDITOR.instances.editor.setData(resp.thesisForm);		 
			}
			,error : function(resp) {
				console.log(resp);
			}
		});
	}
	
	
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="#" style="cursor: auto;">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="far fa-laugh-squint"></i>
				</div>
				<div class="sidebar-brand-text mx-3" style="font-size: 20px;">チーム
					掲示板</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"><a class="nav-link" href="goGroupBoard"> <i
					class="fas fa-book"></i> <span style="font-size: 15px;">掲示板
						ホーム(Team${sessionScope.groupBoardNum})</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">MENU</div>


      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item" id="go_groupBoard">
        <a class="nav-link collapsed" href="groupboard_list">
          <i class="fas fa-fw fa-folder"></i>
          <span>資料共有掲示板</span>
        </a>
      </li>

      <li class="nav-item active">
        <a class="nav-link" href="thesisWrite">
          <i class="fas fa-book-open"></i>
          <span>論文作成</span></a>
      </li>

      <li class="nav-item">
        <a class="nav-link" href="goGroupBoardCalendar">
          <i class="fas fa-calendar-alt"></i>
          <span>スケジュール</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">
				
	 <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
          <ul class="navbar-nav ml-auto">
        
						<li class="nav-item dropdown no-arrow mx-1">
							<div class="dropdown-toggle" data-toggle="dropdown"
								class="dropdown" id="chatForm">
								<a style="font-size: 25px; color: white;"> <i
									class="fas fa-comments" style="color: gray;"></i>
								</a>
							</div>
						</li>
						<li style="width:10px;"></li>
						<li class="nav-item dropdown no-arrow mx-1">
							<div class="dropdown" id="selectFiveMessages">
								<a class="dropdown-toggle" data-toggle="dropdown"
									style="font-size: 25px; color: white;"> <i
									class="fas fa-envelope" style="color: gray;"></i>
									<span class="badge badge-danger badge-counter" id="msgCount"></span>
								</a>
								<ul class="dropdown-menu dropdown-menu-right" role="menu"
									aria-labelledby="dLabel" id="menu">
									<li><div class="listOfMessage" style="width: 500px;"></div></li>
									<li>
										<div class="dropdown-content">
											<a class="dropdown-item text-center" href="viewAllMessages"
												style="text-align: center; font-size: 15px;">全てのメッセージを見る</a>
										</div>
									</li>
								</ul>
							</div>
						</li>
						<li class="nav-item dropdown no-arrow mx-1"><a href="../"
							style="font-size: 25px; color: white;"><i class="fas fa-home"
								style="color: gray;"></i></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>
						<li class="nav-item dropdown no-arrow"><span
							class="mr-2 d-none d-lg-inline text-gray-600 small"
							style="font-size: 20px;">${sessionScope.loginName} 様</span></li>
					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">論文作成(Team${sessionScope.groupBoardNum})</h1>
						<a href="javascript:tempSave();"
							class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
							class="fas fa-save fa-sm text-white-50"></i> 一時保存する</a>
					</div>

					

					<!-- Content Row -->

					<div class="row">

				 <!-- Area Chart -->
            <div  style="width:100%;">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">アブストラクト</h6>
                  <div class="dropdown no-arrow">
                  </div>
                </div>
								 <!-- Card Body -->
                <div class="card-body">
                 	<form action="similarity" method="get" id="similarity">
                 	<p style="font-size: 25px; font-weight: bold;">題目</p><input type = "text" id = "thesisTitle" name="thesisTitle" style = "width:100%;" placeholder="タイトルを入力してください。" value = "${thesisTitle}"><br>
                 	
                 	<br>
                                            <p style="font-size: 25px;font-weight: bold;">抄録</p><textarea id = "thesisAbstract" name = "thesisAbstract" placeholder = "入力してください" style = "width:100%; height:200px; " >${thesisAbstract}</textarea>
                 	<div style="float: right;">
                 	<a class="btn btn-primary" id="translate" href="#"role="button"><i class="fas fa-language fa-lg"></i> 翻訳</a>
                 	<a class="btn btn-primary"	id="similarityButton" href="#"role="button"><i class="far fa-comment-dots fa-lg"></i> 類似性検査</a>
                 	</div>
                 	</form>
             	</div>
            </div>

								<div class="card shadow mb-4">
									<!-- Card Header - Dropdown -->
									<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
										<h6 class="m-0 font-weight-bold text-primary">論文作成</h6>
										<div class="form-group" style = "margin-bottom:0rem;">
										<table>
										<tr>
										<td>
									<select id = "degree" class = "form-control"> 
										<option value = "searchByDegree" selected> 学位 </option>	
										<option value = "graduate">学士</option>
										<option value = "master">修士</option>
										<option value = "doctor">博士</option>
										<option value = "other">その他 </option>
									</select>
									</td>
									<td>
									<select id = "department" class = "form-control" onchange = "javascript:selectThesisForm();"> 
										<option value = "searchByDepartment" selected> 学科 </option>	
										<option value = "education">教育学研究科</option>
										<option value = "economy">経済学研究科 </option>
										<option value = "engineering">工学系研究科 </option>
										<option value = "information">情報理工学系研究科 </option>
										<option value = "frontier science">新領域創成科学研究科</option>
										<option value = "humanities">人文社会系研究科 </option>
										<option value = "mathematics">数理科学研究科 </option>
										<option value = "culture">総合文化研究科 </option>
										<option value = "agriculture">農学生命科学研究科 </option>
										<option value = "law">法学政治学研究科 </option>
										<option value = "pharmacy">薬学系研究科 </option>
										<option value = "sciences">理学系研究科 </option>
									</select>
									</td>
									</tr>
									</table>
										</div>
									</div>
									<!-- Card Body -->
									<div class="card-body" >
										<textarea name="editor" id="editor" rows="400" cols="80" value = "${editor}" ></textarea>
										<br> 
										<form id="final" action="finalSubmit" method="post" enctype="multipart/form-data">
										 <input type = "hidden" name = "seq_thesistemp" value = "${seq_thesistemp }">
										 <div class="filebox">
										<input class="upload-name" value="ファイル選択" disabled="disabled"
											style="vertical-align: top; color: gray; width:500px;"> <label
											for="ex_filename">ファイル添付</label> <input type="file"
											style="width: 100%;" name="upload" id="ex_filename"
											class="upload-hidden">
											<div style="float:right;">
											<a class="btn btn-primary" id="wordCheckButton"
											href="#" role="button"><i class="fas fa-font"></i>原語校正</a>
										<input type="button" class = "btn btn-primary" id="generatePDF" value = "PDFで保存"/>
										</div>
										<br><br> 
										<div style="float:right;"><button type="button" class="btn btn-outline-success" id = "finalButton" style="height:40px;"><i class="fas fa-check"></i> 最終提出</button></div>
										</div>
										</form>
									</div>
								</div>
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->
</div>

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->
			</div>
			<!-- End of Page Wrapper -->

  <!-- Custom scripts for all pages-->
 <script src="<c:url value="/resources/js/sb-admin-2.min.js"/>"></script>
  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>
  <!-- CKeditor4 -->
  <script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

			<!-- Core plugin JavaScript-->
			<script
				src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js"/>"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
			<!-- Custom scripts for all pages-->
			<script src="resources/js/sb-admin-2.min.js"></script>
			<!-- Page level plugins -->
			<script
				src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>
			<!-- CKeditor4 -->
			<script
				src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
</body>

</html>
