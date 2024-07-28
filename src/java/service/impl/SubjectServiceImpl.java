package service.impl;

import dto.SubjectDto;
import entity.Subject;
import java.util.List;
import repository.impl.SubjectRepositoryImpl;
import service.SubjectService;

public class SubjectServiceImpl implements SubjectService {

    private static final SubjectServiceImpl instance = new SubjectServiceImpl();

    private final SubjectRepositoryImpl subjectRepository = SubjectRepositoryImpl.getInstance();

    private SubjectServiceImpl() {
    }

    public static SubjectServiceImpl getInstance() {
        return instance;
    }

    public void saveSubjectManager(String managerEmail, Long subjectId) {
        subjectRepository.saveSubjectManager(managerEmail, subjectId);
    }

    public Subject save(Subject subject) {
        return subjectRepository.save(subject);
    }

    public Subject findById(Long id) {
        return subjectRepository.findById(id);
    }

    public List<Subject> findByName(String name, int itemsPerPage, int currentPage, String sortField, String sortOrder) {
        return subjectRepository.findByName(name, itemsPerPage, currentPage, sortField, sortOrder);
    }

    public int countByName(String name) {
        return subjectRepository.countByName(name);
    }

    public List<Subject> findAll(int itemsPerPage, int currentPage, String sortField, String sortOrder) {
        return subjectRepository.findAll(itemsPerPage, currentPage, sortField, sortOrder);
    }

    public int countAll() {
        return subjectRepository.countAll();
    }

    public void removeSubjectManagers(String managerEmail, Long subjectId) {
        subjectRepository.removeSubjectManagers(managerEmail, subjectId);
    }

    public List<Subject> findAll() {
        return subjectRepository.findAll();
    }

    public List<SubjectDto> getSubjectStatisticsByStudent(Long studentId, String searchQuery) {
        return subjectRepository.getSubjectStatisticsByStudent(studentId, searchQuery);
    }
}
