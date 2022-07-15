package org.example.sweater.repo;

import org.example.sweater.domain.Message;
import org.example.sweater.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface MessageRepo extends CrudRepository<Message, Integer>{
    Page<Message> findAll(Pageable pageable);

    Page<Message> findAllByAuthor(User user, Pageable pageable);
    Page<Message> findByTag(String tag, Pageable pageable);

}
