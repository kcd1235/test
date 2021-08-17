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
<jsp:useBean id="bMgr" class="Ch20.BoardMgr" scope="page" />
<%@page import="java.util.*,Ch20.BoardBean" %>	<!-- ArrayList 사용위한 클래스 경로 설정-->
<%
	int totalRecord=0;
	int numPerPage=5;
	int totalPage=0;
	int totalBlock=0;
	int nowPage=1;
	int nowBlock=1;
	int pagePerBlock=10;//블럭당 페이지수(한블럭에 [1][2][3][4]...[15]까지 페이지 표시)
	
	int start=0;
	int end=5;
	String keyWord="";// 검색할 문자열
	String keyField="";//이름 제목 내용
	
	//키워드 검색 시작
	if(request.getParameter("keyWord")!=null){
		keyWord=request.getParameter("keyWord");
		keyField=request.getParameter("keyField");
	}
	//키워드 검색 끝
	
	if(request.getParameter("reload")!=null){
		if(request.getParameter("reload").equals("true")){
			keyWord=""; keyField="";
		}
	}
	int listSize=0;
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}
	start=(nowPage*numPerPage)-numPerPage;
	end=numPerPage;
	totalRecord=bMgr.getTotalCount(keyField,keyWord); //검색내용을 전달하여 만족하는 전체 레코드수 리턴
	totalPage= (int)Math.ceil((double)totalRecord/ numPerPage);	//전체 페이수 계산(1000개 게시물일때 페이수는 100페이지)
	totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);	//총 블럭(15개단위)개수 계산(1000개 게시물일때 블럭수는 7)
	nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock); // 현재 블럭 계산(총블럭에서 몇번째인지)
	
	
	ArrayList<BoardBean> blist = bMgr.getBoardList(keyField, keyWord, start, end);
	
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
	<div align="center">
<br>
<h2>공지사항</h2>
<ul>
	<li>전체</li>
	<li>메가박스공지</li>
	<li>지점공지</li>
</ul>
<br>
<!-- 상단  -->
<table align="center" width="1000">
<tr>
	<td>Total : <%=totalPage%> Page(<font color=red><%=nowPage %> Page</font>/<%=totalPage %> Page)<br></td>
</tr>
</table>
<!-- 본문  -->
<table align=center width="1000">
<tr>
	<!-- 게시물 내용 출력  -->
	<td colspan=2>
	<table width=1000>
		<tr align=center bgcolor=lightgray>
			<td>번호</td>
			<td>극장</td>
			<td>구분</td>
			<td>제목</td>
			<td>등록일</td>
		</tr>
		
		<%
			listSize=blist.size();	//가져온 게시물의 개수를 listSize에 저장
			if(blist.isEmpty())
			{
				out.println("등록된 게시물이 없습니다.");
			}
			else
			{
				for(int i=0;i<numPerPage;i++)
				{
					if(i==listSize)
						break;
					
					BoardBean bean = blist.get(i);				
		%>
		<tr>
			<td align=center><%=bean.getNum() %></td>
			<td>
			<%
				int depth=bean.getDepth();
				if(depth>0)		//부모게시글이 아니라면(답변글 or 답변의 답변글)
				{
					for(int j=0;j<depth;j++)	
					{
						out.println("&nbsp;&nbsp");		//depth가 1이라면 공백 한 번 추가
					}
				}
			%>
			<a href="javascript:read('<%=bean.getNum()%>')"><%=bean.getSubject() %></a>
			</td>
			<td align=center><%=bean.getName() %></td>
			<td align=center><%=bean.getRegdate() %></td>
			<td align=center><%=bean.getCount()%></td>
		</tr>
	
		<%
				}
			}
		%>	
	</table>
	</td>
</tr>
<tr>
	<td colspan=2><br></td>
</tr>
<tr>
	<!-- 페이지블럭 출력 [1][2][3][4][5][6][7]-->
	<td>
	<% 
		int pageStart=(nowBlock -1)*pagePerBlock + 1;	//블럭 시작 번호(1000게시물일때 블럭총개수:7)
		int pageEnd=((pageStart + pagePerBlock)<=totalPage)?(pageStart+pagePerBlock) :totalPage+1;
	
		if(totalPage!=0)
		{
			if(nowBlock>1)
			{
				%>
					<a href="javascript:block('<%=nowBlock-1%>')">[이전으로]</a>&nbsp;
				<%
			}
			for(;pageStart<pageEnd;pageStart++)
			{
				%>
				<a href="javascript:paging('<%=pageStart%>')">[<%=pageStart%>]</a>
				<%
			}
			if(totalBlock>nowBlock){
				%>
					<a href="javascript:block('<%=nowBlock+1%>')">[다음으로]</a>
				<%
			}
			
		}
	%>
	
	
	</td>
	<!-- 글쓰기기능/처음으로가기능 추가 -->
	<td align=right>
		<a href="Post.jsp">[글쓰기]</a><a href="javascript:list()">[처음으로]</a>
	</td>
</tr>

</table>

<!-- 검색 -->
<form name=searchFrm method=get action=List.jsp>
<table width=1000 >
	<tr>
		<td align=center>
			<select name=keyField size=1>
				<option value=name>이 름 </option>
				<option value=subject>제 목 </option>
				<option value=content>내 용 </option>
			</select>
			<input size=16 name=keyWord>
			<input type=button value=찾기 onclick="javascript:check()">
			<input type=hidden name=nowPage value=1>
		</td>
	</tr>
</table>
</form>


<!--페이징 처리를 위한 Form-->
<form name=readFrm method=get>
	<input type="hidden" name="num">
	<input type="hidden" name="nowPage" value=<%=nowPage%>>
	<input type="hidden" name="keyField" value=<%=keyField %>>
	<input type="hidden" name="keyWord" value=<%=keyWord %>>
</form>

<!--처음으로 기능 처리 시작  -->
<form method="post" name=listFrm>
	<input type="hidden" name=reload value=true>
	<input type="hidden" name=nowPage value=1>
</form>
<!--처음으로 기능 처리 끝  -->
</div>
	
</content>
<section></section>
<footer>
<%@ include file="jsp/footerContents.jsp" %>
</footer>

</body>
</html>