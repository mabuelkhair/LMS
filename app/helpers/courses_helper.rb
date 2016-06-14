module CoursesHelper
	def in_course
		!(@course.students.include? current_user)
	end
end
