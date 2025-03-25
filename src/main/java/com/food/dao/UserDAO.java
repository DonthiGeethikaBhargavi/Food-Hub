package com.food.dao;

import java.util.List;

import com.food.model.User;

public interface UserDAO {
    void addUser(User user);
    User getUser(int userId);
    void updateUser(User user);
    void deleteUser(int userId);
    List<User>getAllUsers();
    boolean validateUser(String username, String password);
	User getUserByUsername(String username);
}
