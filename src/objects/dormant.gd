extends SpaceObject
class_name Dormant

func update_connections(visited: Array[SpaceObject] = []) -> int:
		if self in visited:
				return signal_strength

		visited.append(self)

		var sum := 0
		if input.size()>0:
			sum = input[0].signal_strength *2

		signal_strength = sum
		show_debug()

		for connected in output:
			if connected==self:
				continue
			if visited.has(self):
				continue
			connected.update_connections(visited)

		return signal_strength
