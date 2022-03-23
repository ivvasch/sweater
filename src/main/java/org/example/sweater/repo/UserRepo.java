package org.example.sweater.repo;

import org.example.sweater.domain.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepo extends CrudRepository<User, Integer> {
    User findUserByUsername(String username);

    User findByActivationCode(String code);

    List<User> findAll();
}
