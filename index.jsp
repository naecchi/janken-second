<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>じゃんけんゲーム</title>
<style type="text/css">
  html, body {
    height: 100%;
    width: 100%;
    padding: 0;
    margin: 0;
  }

  body {
    display: flex;
    flex-direction: column;
  }

  header {
    width: 100%;
    height: 60px;
    background-color : black;
    color: white;
    text-align: center;
    font-size: 30px;
  }

  header div {
    height: 100%;
    padding-top: 8px;
  }

  main {
    flex: auto;
    font-size: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
  }


  footer {
    background-color : black;
    width: 100%;
    height: 110px;
    text-align: center;
  }

  footer div {
    height: 90%;
    padding-top: 4px;
    display: flex;
    justify-content: center;
  }

  footer div button {
    flex: 0.2;
    background-color : white;
    margin: 0 4px;
    height: 50px;
    font-size: 30px;
  }

  footer div button:hover {
    background-color : yellow;
  }

  .selected {
    background-color : yellow;
  }
</style>
</head>
<body>
	<header>
		<div>「さあ、じゃんけんで勝負だ！」</div>
	</header>

	<%//1mr]メイン画面で所持金をセットをする
	//所持金
	int money = 0;
	if(session.getAttribute("money")!=null){
		money = (int)session.getAttribute("money");
	}
	%>

	<main>
	<div>
	<%
	  String jibun = (String) request.getAttribute("jibun");
	  String com = (String) request.getAttribute("com");
	  String shohai = (String) request.getAttribute("shohai");
	  if (com == null) {
     %>
		じゃんけん・・・
	<% } else { %>
		<%if ("0".equals(com)) { %>
			グー
		<% } else if ("1".equals(com)) {  %>
			チョキ
		<% } else if ("2".equals(com)) {  %>
			パー
		<% } %>
	<% } %>
	</div>
	<div>
		<%if ("-1".equals(shohai)) { %>
			負け
		<% } else if ("0".equals(shohai)) {  %>
			あいこ
		<% } else if ("1".equals(shohai)) {  %>
			勝ち
		<% } %>
	</div>

	</main>
	<!-- 現在の所持金 -->
	<div class = "money"><h3>所持金: <%out.println(money); %></h3> </div>


	<footer>
		<form action="Janken" method="POST">


		<%//comの手が決まった時、かつ、あいこでない時、勝敗が決まった時
		//ぐー、ちょき、ぱーボタンを使えなくする、MainRoom.jspへ戻るよう誘導するため
		if (com != null&& !("0".equals(shohai))) {%>
			<div>
				<button class="<%= "0".equals(jibun) ? "selected" : ""  %>" disabled="disabled"
				  onClick="document.getElementById('jibun').value = '0'; "id="b2">グー</button>
				<button class="<%= "1".equals(jibun) ? "selected" : ""  %>" disabled="disabled"
				  onClick="document.getElementById('jibun').value = '1'">チョキ</button>
				<button class="<%= "2".equals(jibun) ? "selected" : ""  %>" disabled="disabled"
				  onClick="document.getElementById('jibun').value = '2'">パー</button>
				<input type="hidden" id="jibun" name="jibun" />

			</div>

		<%}//勝負が決まってない時
		else{ %>
			<div>
				<button class="<%= "0".equals(jibun) ? "selected" : ""  %>"
				  onClick="document.getElementById('jibun').value = '0'; ">グー</button>
				<button class="<%= "1".equals(jibun) ? "selected" : ""  %>"
				  onClick="document.getElementById('jibun').value = '1'">チョキ</button>
				<button class="<%= "2".equals(jibun) ? "selected" : ""  %>"
				  onClick="document.getElementById('jibun').value = '2'">パー</button>
				<input type="hidden" id="jibun" name="jibun" />

			</div>
		<%} %>
			<%
			//所持金をセット、//テスト●
			session.setAttribute("money", money);
			%>
		</form>

		<%//comの手が決まった時、かつ、あいこでない時、勝敗が決まった時
		//MainRoom.jspへ戻るボタン
		if (com != null&& !("0".equals(shohai))) {%>

		<form action="Janken" method = "get">
			<div>
				<button onClick="document.getElementById('jibun').value = ''">終了</button>
			</div>
		</form>

		<%} %>
	</footer>
</body>
</html>