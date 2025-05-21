package com.Movierental.servlet.admin;

import com.google.gson.Gson;
import com.Movierental.dao.UserDAO;
import com.Movierental.model.User;
import com.Movierental.model.AdminUser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServlet;

@WebServlet("/admin/admins/*")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = UserDAO.getInstance();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        HttpSession session = request.getSession();
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }
        if (session.getAttribute("success") != null) {
            request.setAttribute("success", session.getAttribute("success"));
            session.removeAttribute("success");
        }
        
        if (pathInfo == null || pathInfo.equals("/")) {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/admin/admins.jsp").forward(request, response);
        } else {
            String userId = pathInfo.substring(1);
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                request.setAttribute("editUser", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/user-edit.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        response.setCharacterEncoding("UTF-8");

        if ("/delete".equals(pathInfo)) {
            response.setContentType("application/json");
            java.io.PrintWriter out = response.getWriter();
            java.util.Map<String, Object> result = new java.util.HashMap<>();
            try {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = request.getReader().readLine()) != null) {
                    sb.append(line);
                }
                java.util.Map<String, String> data = gson.fromJson(sb.toString(), java.util.Map.class);
                String userId = data.get("userId");
                if (userDAO.deleteUser(userId)) {
                    result.put("success", true);
                    result.put("message", "Admin deleted successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "Failed to delete admin");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                result.put("success", false);
                result.put("message", "An error occurred while deleting the admin");
            }
            out.print(gson.toJson(result));
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");

            if (username == null || password == null || fullName == null || email == null ||
                username.trim().isEmpty() || password.trim().isEmpty() || 
                fullName.trim().isEmpty() || email.trim().isEmpty()) {
                session.setAttribute("error", "All fields are required");
                response.sendRedirect(request.getContextPath() + "/admin/admins");
                return;
            }

            String userId = UUID.randomUUID().toString();
            User newUser = new AdminUser(
                userId,
                username.trim(),
                password,
                fullName.trim(),
                email.trim(),
                "",
                "",
                "default-avatar.jpg",
                "Management",
                "Administrator"
            );

            if (userDAO.addUser(newUser)) {
                session.setAttribute("success", "Admin created successfully");
            } else {
                session.setAttribute("error", "Username already exists");
            }
            response.sendRedirect(request.getContextPath() + "/admin/admins");
            
        } else if ("delete".equals(action)) {
            String userId = request.getParameter("userId");
            if (userDAO.deleteUser(userId)) {
                session.setAttribute("success", "Admin deleted successfully");
            } else {
                session.setAttribute("error", "Failed to delete admin");
            }
            response.sendRedirect(request.getContextPath() + "/admin/admins");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/admins");
        }
    }
} 