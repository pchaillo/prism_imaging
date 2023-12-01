% Your data
student(1).grades.math = 7;
student(2).grades.math = 9;
student(3).grades.math = 6;
% Use arrayfun to extract all the math grades into vector
mathGrades = arrayfun(@(x) x.grades.math, student)