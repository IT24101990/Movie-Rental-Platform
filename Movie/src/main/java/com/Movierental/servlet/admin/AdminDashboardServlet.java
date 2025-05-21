package com.Movierental.servlet.admin;

import com.Movierental.dao.UserDAO;
import com.Movierental.model.User;
import com.Movierental.model.AdminUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import javax.servlet.http.HttpServlet;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = UserDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (!(user instanceof AdminUser)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("totalUsers", userDAO.getTotalUserCount());
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
} 