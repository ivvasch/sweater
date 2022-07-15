package org.example.sweater.domain;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.Collection;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "usr")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @NotBlank(message = "Username couldn't be null")
    private String username;
    private boolean active;
    @NotBlank(message = "Password couldn't be null")
    private String password;
    @Email(message = "Email is not correct")
    @NotBlank(message = "Email couldn't be null")
    private String email;
    private String activationCode;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roleSet;


    @OneToMany(mappedBy ="author", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Message> messages;

    @ManyToMany
    @JoinTable(
            name = "user_subscription",
            joinColumns = {@JoinColumn(name = "chanel_id")},
            inverseJoinColumns = {@JoinColumn(name = "cubscriber_id")}
    )
    private Set<User> subscribers = new HashSet<>();
    @ManyToMany
    @JoinTable(
            name = "user_subscription",
            joinColumns = {@JoinColumn(name = "cubscriber_id")},
            inverseJoinColumns = {@JoinColumn(name = "chanel_id")}
    )
    private Set<User> subscribtion = new HashSet<>();

    public boolean isAdmin() {
        return roleSet.contains(Role.ADMIN);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoleSet();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public boolean isActive() {
        return active;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(id, user.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
