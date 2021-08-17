<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<%@ include file="jsp/link.jsp" %>

</head>
<style>
	*{height:20px;}
</style>
<body>
<%
	int totalRecord=0;
	int numPerPage=5;
	int totalPage=0;
	int totalBlock=0;
	int nowPage=1;
	int nowBlock=1;
	
	int start=0;
	int end=5;
	
	int listSize=0;
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}
	start=(nowPage*numPerPage)-numPerPage;
	end=numPerPage;
	/* totalRecord=bMgr.getTotalCount(keyField, keyWord); //검색내용을 전달하여 만족하는 전체 레코드수 리턴
	totalPage= (int)Math.ceil((double)totalRecord/ numPerPage);	//전체 페이수 계산(1000개 게시물일때 페이수는 100페이지)
	totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);	//총 블럭(15개단위)개수 계산(1000개 게시물일때 블럭수는 7)
	nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock); // 현재 블럭 계산(총블럭에서 몇번째인지)
	
	
	ArrayList<BoardBean> blist = bMgr.getBoardList(keyField, keyWord, start, end); */
	
%>
<script>
function paging(page){
	document.readFrm.nowPage.value=page;
	document.readFrm.submit();
}

function block(value){
	<%-- document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1; --%>	//이동하는 블럭의 시작페이지 계산-> 15*(value-1)+1
	document.readFrm.submit();
}

function list(){
	document.listFrm.action="List.jsp";
	document.listFrm.submit();
}

function check(){
	if(document.searchFrm.keyWord.value==""){
		alert("검색어를 입력하세요");
		document.searchFrm.keyWord.focus();
		
	}
	else{
		document.searchFrm.submit();
	}
}

function read(num){
	document.readFrm.num.value=num;
	document.readFrm.action="Read.jsp";
	document.readFrm.submit();
}
</script>

<header>
<jsp:include page="module/header.jsp" />
</header>

<nav>
<jsp:include page="module/nav.jsp" />
</nav>

<aside>
<jsp:include page="module/aside.jsp" />
</aside>


<content>
	고객센터 홈
	<form name=searchFrm method=get action=List.jsp>
		<table width=1000 >
	<tr>
		<td>빠른검색</td>
		<td align=center>
			<input size=16 name=keyWord>
			<input type=button value=찾기 onclick="javascript:check()">
			<input type=hidden name=nowPage value=1>
		</td>
	</tr>
</table>
</form>
	<hr>
	
</content>
<section></section>
<footer>
<%@ include file="jsp/footerContents.jsp" %>
</footer>

</body>
</html>