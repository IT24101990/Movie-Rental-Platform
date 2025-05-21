package com.Movierental.servlet.admin;

import com.Movierental.dao.UserDAO;
import com.Movierental.model.User;
import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/delete-account")
public class DeleteAccountServlet extends HttpServlet {
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        userDAO = UserDAO.getInstance();
        gson = new Gson();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();

        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            
            if (currentUser == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                result.put("success", false);
                result.put("message", "User not logged in");
                out.print(gson.toJson(result));
                return;
            }

            String password = request.getReader().lines()
                    .reduce("", (accumulator, actual) -> accumulator + actual);
            Map<String, String> requestData = gson.fromJson(password, Map.class);
            password = requestData.get("password");

            if (!userDAO.verifyPassword(currentUser.getId(), password)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                result.put("success", false);
                result.put("message", "Invalid password");
                out.print(gson.toJson(result));
                return;
            }

            boolean deleted = userDAO.deleteUser(currentUser.getId());
            
            if (deleted) {
                session.invalidate();
                result.put("success", true);
                result.put("message", "Account deleted successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                result.put("success", false);
                result.put("message", "Failed to delete account");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            result.put("success", false);
            result.put("message", "An error occurred while deleting the account");
        }

        out.print(gson.toJson(result));
    }
} 