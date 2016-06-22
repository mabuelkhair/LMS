module QuizzesHelper
	def not_solved_before(quiz_id)
		if Answer.where(:quiz_id => quiz_id , :user_id => current_user.id).count == 0 then
			return true
		else
			return false
		end
	end
end
