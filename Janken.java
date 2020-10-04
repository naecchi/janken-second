package controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Janken
 */
@WebServlet("/Janken")
public class Janken extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /** グー. */
    private static final String GU = "0";
    /** チョキ. */
    private static final String CHOKI = "1";
    /** パー. */
    private static final String PA = "2";

    /** 勝ち. */
    private static final String KACHI = "1";
    /** あいこ. */
    private static final String AIKO = "0";
    /** 負け. */
    private static final String MAKE = "-1";



    /**
     * @see HttpServlet#HttpServlet()
     */
    public Janken() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        getServletConfig().getServletContext()
        .getRequestDispatcher("/MainRoom.jsp")//テスト●
        .forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // パラメータを取得
        String jibun = request.getParameter("jibun");



        HttpSession session = request.getSession(true);//テスト●
      //所持金を返す、session//修正●staticで共通できるかも
      	int money = (int)session.getAttribute("money");

        // パラメータが存在しない場合
        if (jibun == null || "".equals(jibun)) {
            getServletConfig().getServletContext()
                    .getRequestDispatcher("/index.jsp")
                    .forward(request, response);
            return;
        }

        // コンピュータの出し手を選択
        Random random = new Random();
        String com = String.valueOf(random.nextInt(3));

        // あいこの場合
        if (jibun.equals(com)) {
            request.setAttribute("shohai", AIKO);
        } else {

            // 勝ち
            if ((GU.equals(jibun) && CHOKI.equals(com))
                || (CHOKI.equals(jibun) && PA.equals(com))
                || (PA.equals(jibun) && GU.equals(com))
            ) {
            	//所持金を増やす
            	money += 10;
                request.setAttribute("shohai", KACHI);


            } else {
            	//所持金を減らす
            	money -= 10;
                request.setAttribute("shohai", MAKE);
            }
        }

        request.setAttribute("com", com);
        request.setAttribute("jibun", jibun);

      //所持金をセット、//テスト●
		session.setAttribute("money", money);

        getServletConfig().getServletContext()
        .getRequestDispatcher("/index.jsp")
        .forward(request, response);
    }

}