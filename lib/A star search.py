# import heapq
#
# start = (0, 0)
# end = (4, 4)
#
# maze = [
#     [0, 1, 0, 0, 0],
#     [0, 1, 0, 1, 0],
#     [0, 0, 0, 0, 0],
#     [0, 1, 1, 1, 0],
#     [0, 0, 0, 1, 0]
# ]
#
#
# def solve_by_astar(start, end, maze):
#     if 0 <= start[0] < len(maze) and 0 <= start[1] < len(maze[0]) and maze[start[0]][start[1]] != 1 or 0 <= end[
#         0] < len(maze) \
#             and 0 <= end[1] < len(maze[0]) and maze[end[0]][end[1]] != 1:
#
#         class Node:
#             def __init__(self, position, parent=None):
#                 self.position = position
#                 self.parent = parent
#                 self.g = 0
#                 self.h = 0
#                 self.f = 0
#
#             def __lt__(self, other):
#                 return self.f < other.f
#
#             def __eq__(self, other):
#                 return self.position == other.position
#
#         def heuristic(current, goal):
#             return abs(current[0] - goal[0]) + abs(current[1] - goal[1])
#
#         def get_neighbors(current, maze):
#             neighbors = []
#             moves = [(1, 0), (-1, 0), (0, 1), (0, -1)]  # Right, Left, Down, Up
#             for move in moves:
#                 neighbor_pos = (current[0] + move[0], current[1] + move[1])
#                 if 0 <= neighbor_pos[0] < len(maze) and 0 <= neighbor_pos[1] < len(maze[0]) and maze[neighbor_pos[0]][
#                     neighbor_pos[1]] != 1:
#                     neighbors.append(neighbor_pos)
#             return neighbors
#
#         def astar(maze, start, end):
#             open_list = []
#             closed_set = set()
#
#             start_node = Node(start)
#             start_node.g = start_node.h = start_node.f = 0
#             heapq.heappush(open_list, start_node)
#
#             while open_list:
#                 current_node = heapq.heappop(open_list)
#                 closed_set.add(current_node.position)
#
#                 if current_node.position == end:
#                     path = []
#                     while current_node:
#                         path.append(current_node.position)
#                         current_node = current_node.parent
#                     return path[::-1]
#
#                 neighbors = get_neighbors(current_node.position, maze)
#                 for neighbor_pos in neighbors:
#                     if neighbor_pos in closed_set:
#                         continue
#
#                     neighbor_node = Node(neighbor_pos, current_node)
#                     neighbor_node.g = current_node.g + 1
#                     neighbor_node.h = heuristic(neighbor_pos, end)
#                     neighbor_node.f = neighbor_node.g + neighbor_node.h
#
#                     if neighbor_node not in open_list:
#                         heapq.heappush(open_list, neighbor_node)
#                     else:
#                         existing = [n for n in open_list if n == neighbor_node][0]
#                         if neighbor_node.g < existing.g:
#                             existing.g = neighbor_node.g
#                             existing.f = existing.g + existing.h
#                             existing.parent = current_node
#
#             return None
#
#         path = astar(maze, start, end)
#
#         if path:
#             print("Path found:", path)
#         else:
#             print("No path found.")
#     else:
#         print("not valid")
#
#
#
