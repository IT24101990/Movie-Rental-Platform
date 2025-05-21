package com.Movierental.dao;

import com.Movierental.model.User;
import com.Movierental.model.AdminUser;
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;

public class UserDAO {
    private static final String USERS_FILE = "data" + File.separator + "users.txt";
    private Map<String, User> users;
    private static UserDAO instance;
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private UserDAO() {
        users = new HashMap<>();
        loadUsers();
    }

    public static UserDAO getInstance() {
        if (instance == null) {
            instance = new UserDAO();
        }
        return instance;
    }

    private void loadUsers() {
        File file = new File(USERS_FILE);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            AdminUser adminUser = new AdminUser(
                UUID.randomUUID().toString(),
                "admin",
                "admin",
                "Administrator",
                "admin@movie.com",
                "",
                "",
                "default-avatar.jpg",
                "IT",
                "System Administrator"
            );
            users.put(adminUser.getId(), adminUser);
            saveUsers();
            System.out.println("Created default admin user: admin/admin at " + USERS_FILE);
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    String[] parts = line.split(",");
                    if (parts.length < 8) {
                        System.out.println("Skipping invalid line: " + line);
                        continue;
                    }
                    
                    User user = null;
                    String id = parts[0];
                    String username = parts[1];
                    String password = parts[2];
                    String fullName = parts[3];
                    String email = parts[4];
                    String phone = parts[5];
                    String address = parts[6];
                    String avatarUrl = "default-avatar.jpg";
                    
                    if ("ADMIN".equals(parts[7])) {
                        String department = parts.length > 8 ? parts[8] : "IT";
                        String title = parts.length > 9 ? parts[9] : "Administrator";
                        user = new AdminUser(
                            id, username, password, fullName, email,
                            phone, address, avatarUrl, department, title
                        );
                        users.put(user.getId(), user);
                        System.out.println("Loaded user: " + username);
                    } else {
                        System.out.println("Skipping non-admin user: " + username);
                    }
                } catch (Exception e) {
                    System.out.println("Error processing line: " + line);
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading users file: " + e.getMessage());
            e.printStackTrace();
        }

        if (users.isEmpty()) {
            AdminUser adminUser = new AdminUser(
                UUID.randomUUID().toString(),
                "admin",
                "admin",
                "Administrator",
                "admin@movie.com",
                "",
                "",
                "default-avatar.jpg",
                "IT",
                "System Administrator"
            );
            users.put(adminUser.getId(), adminUser);
            saveUsers();
            System.out.println("Created default admin user: admin/admin at " + USERS_FILE);
        }
    }

    private void saveUsers() {
        try {
            File file = new File(USERS_FILE);
            if (!file.exists()) {
                file.getParentFile().mkdirs();
                file.createNewFile();
            }
            try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
                for (User user : users.values()) {
                    writer.println(user.toString());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public User getUserById(String id) {
        return users.get(id);
    }

    public User getUserByUsername(String username) {
        return users.values().stream()
            .filter(u -> u.getUsername().equals(username))
            .findFirst()
            .orElse(null);
    }

    public List<User> getAllUsers() {
        return new ArrayList<>(users.values());
    }

    public List<User> searchUsers(String searchQuery) {
        final String query = searchQuery.toLowerCase();
        return users.values().stream()
            .filter(u -> u.getUsername().toLowerCase().contains(query) ||
                        u.getFullName().toLowerCase().contains(query) ||
                        u.getEmail().toLowerCase().contains(query))
            .collect(Collectors.toList());
    }

    public boolean addUser(User user) {
        if (getUserByUsername(user.getUsername()) != null) {
            return false;
        }
        users.put(user.getId(), user);
        saveUsers();
        return true;
    }

    public boolean updateUser(User user) {
        if (users.containsKey(user.getId())) {
            users.put(user.getId(), user);
            saveUsers();
            return true;
        }
        return false;
    }

    public boolean deleteUser(String id) {
        if (users.remove(id) != null) {
            try {
                // Create a new file to ensure clean write
                File file = new File(USERS_FILE);
                if (file.exists()) {
                    file.delete();
                }
                file.createNewFile();
                

                try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
                    for (User user : users.values()) {
                        writer.println(user.toString());
                    }
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }

    public boolean authenticate(String username, String password) {
        User user = getUserByUsername(username);
        return user != null && user.getPassword().equals(password) && user.isActive();
    }

    public List<AdminUser> getAllAdmins() {
        return users.values().stream()
            .filter(u -> u instanceof AdminUser)
            .map(u -> (AdminUser) u)
            .collect(Collectors.toList());
    }

    public boolean validateUser(String username, String password) {
        User user = getUserByUsername(username);
        return user != null && user.getPassword().equals(password) && user.isActive();
    }

    public boolean verifyPassword(String userId, String password) {
        User user = getUserById(userId);
        return user != null && user.getPassword().equals(password);
    }

    public boolean updatePassword(String userId, String newPassword) {
        User user = getUserById(userId);
        if (user != null) {
            user.setPassword(newPassword);
            saveUsers();
            return true;
        }
        return false;
    }

    public boolean changeUserRole(String userId, String newRole) {
        User user = getUserById(userId);
        if (user == null) {
            return false;
        }

        User newUser = null;
        if ("ADMIN".equals(newRole)) {
            newUser = new AdminUser(
                user.getId(),
                user.getUsername(),
                user.getPassword(),
                user.getFullName(),
                user.getEmail(),
                user.getPhoneNumber(),
                user.getAddress(),
                user.getAvatarUrl(),
                "IT",
                "Administrator"
            );
        } else {
            return false;
        }

        users.put(userId, newUser);
        saveUsers();
        return true;
    }

    public int getTotalUserCount() {
        return users.size();
    }
} 