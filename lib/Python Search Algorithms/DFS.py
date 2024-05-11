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

def solve_by_dfs(start, end, maze):
    start_time = time.time()

    def is_valid_move(maze, row, col, visited):
        num_rows = len(maze)
        num_cols = len(maze[0])
        return (row >= 0 and row < num_rows and
                col >= 0 and col < num_cols and
                maze[row][col] == 0 and
                not visited[row][col])

    def dfs(maze, start, end):
        stack = [start]
        visited = set()
        parent = {}

        while stack:
            current = stack.pop()
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
                    stack.append(neighbor)
                    parent[neighbor] = current

        return None

    def get_neighbors(current, maze):
        neighbors = []
        moves = [(1, 0), (-1, 0), (0, 1), (0, -1)]  # Right, Left, Down, Up
        for move in moves:
            neighbor_pos = (current[0] + move[0], current[1] + move[1])
            if 0 <= neighbor_pos[0] < len(maze) and 0 <= neighbor_pos[1] < len(maze[0]) and maze[neighbor_pos[0]][neighbor_pos[1]] != 1:
                neighbors.append(neighbor_pos)
        return neighbors

    path = dfs(maze, start, end)

    if path:
        print("Path found:", path)
    else:
        print("No path found.")

    end_time = time.time()
    execution_time = end_time - start_time
    print("Execution time:", execution_time, "seconds")

solve_by_dfs(start, end, maze)
