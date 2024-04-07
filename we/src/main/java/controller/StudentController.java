package controller;

import model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private HibernateTemplate hibernateTemplate;

    @GetMapping("/{offset}")
    public String getStudents(@PathVariable int offset, Model model) {
        int limit = 2; // Number of data to retrieve at a time
        int start = offset * limit; // Calculate the starting index

        List<Student> students = hibernateTemplate.execute(session ->
                session.createQuery("FROM Student")
                        .setFirstResult(start)
                        .setMaxResults(limit)
                        .list());

        model.addAttribute("students", students);
        return "student-list";
    }
}
