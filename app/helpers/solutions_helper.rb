module SolutionsHelper
	def submitted_before (assignment_id)
		counter = Assignment.find(assignment_id).solutions.where(:student_id => current_user.id).count
		if counter > 0 then
			return true
		else
			return false
		end
	end
end
