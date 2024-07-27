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

    public void saveSubjectManager(Long userId, Long subjectId) {
        subjectRepository.saveSubjectManager(userId, subjectId);
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

    public void updateSubjectManagers(Long subjectId, String[] managerIds) {
        subjectRepository.deleteSubjectManagers(subjectId);
        for (String managerId : managerIds) {
            subjectRepository.saveSubjectManager(Long.valueOf(managerId), subjectId);
        }
    }

    public void removeSubjectManagers(Long subjectId) {
        subjectRepository.removeSubjectManagers(subjectId);
    }

    public List<Subject> findAll() {
        return subjectRepository.findAll();
    }

    public List<SubjectDto> getSubjectStatisticsByStudent(Long studentId) {
        return subjectRepository.getSubjectStatisticsByStudent(studentId);
    }
}
