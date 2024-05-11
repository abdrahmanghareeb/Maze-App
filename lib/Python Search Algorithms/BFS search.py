from collections import deque
import time

start = (2, 4)
end = (9, 9)

maze = [
    [0, 1, 0, 0, 0, 1, 1, 0, 0, 1],
    [0, 1, 0, 1, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0, 0, 1, 0, 0, 0],
    [0, 1, 0, 0, 0, 1, 1, 0, 0, 1],
    [0, 1, 0, 1, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
]

def solve_by_bfs(start, end, maze):
    start_time = time.time()  # Record start time

    if 0 <= start[0] < len(maze) and 0 <= start[1] < len(maze[0]) and maze[start[0]][start[1]] != 1 or 0 <= end[0] < len(maze) \
            and 0 <= end[1] < len(maze[0]) and maze[end[0]][end[1]] != 1:

        def get_neighbors(current, maze):
            neighbors = []
            moves = [(1, 0), (-1, 0), (0, 1), (0, -1)]  # Right, Left, Down, Up
            for move in moves:
                neighbor_pos = (current[0] + move[0], current[1] + move[1])
                if 0 <= neighbor_pos[0] < len(maze) and 0 <= neighbor_pos[1] < len(maze[0]) and maze[neighbor_pos[0]][neighbor_pos[1]] != 1:
                    neighbors.append(neighbor_pos)
            return neighbors

        def bfs(maze, start, end):
            queue = deque([start])
            visited = set()
            parent = {}

            while queue:
                current = queue.popleft()
                visited.add(current)

                if current == end:
                    path = []
                    while current != start:
                        path.append(current)
                        current = parent[current]
                    path.append(start)
                    return path[::-1]  # Reversed path from start to end

                for neighbor in get_neighbors(current, maze):
                    if neighbor not in visited:
                        queue.append(neighbor)
                        parent[neighbor] = current

            return None

        path = bfs(maze, start, end)

        if path:
            print("Path found:", path)
        else:
            print("No path found.")
    else:
        print("not valid")

    end_time = time.time()  # Record end time
    execution_time = end_time - start_time
    print("Execution time:", execution_time, "seconds")

solve_by_bfs(start, end, maze)
