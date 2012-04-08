#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include "mesh.h"

#define MAXLINESIZE 256

/*
 *
 * LOCAL HELPER FUNCTIONS
 *
 */

double edge_length(edge_t edge)
{
    node_t *n1 = edge.up;
    node_t *n2 = edge.down;

    double dx = n1->x - n2->x;
    double dy = n1->y - n2->y;
    return sqrt(dx * dx + dy * dy);
}

double cell_area(cell_t cell)
{
    int i;
    double area;

    for(i = 0; i < (int)cell.nb_nodes; i++)
    {
        area += cell.node[i]->x * cell.node[i + 1]->y;
        area -= cell.node[i]->y * cell.node[i + 1]->x;
    }

    area += cell.node[0]->y * cell.node[cell.nb_nodes - 1]->x;
    area -= cell.node[cell.nb_nodes - 1]->y * cell.node[0]->x;

    return fabs(area / 2);
}

void read_nodes(mesh_t *mesh, char *filename)
{
    int id, x, y, b;
    int nb_attr, border;

    FILE *fd;
    char buf[MAXLINESIZE];

    fd = fopen(filename, "r");

    /* first read the 'header' */
    fscanf(fd, "%d %d %d %d", &(mesh->nb_nodes), &(mesh->dim), &nb_attr, &border);

    mesh->node = (node_t *)malloc(sizeof(node_t) * mesh->nb_nodes);

    /* TODO: find out what's the deal with the attributes and read them */
    /* TODO: also should probably read the number of points according to the dim */
    while(fgets(buf, MAXLINESIZE, fd) !=  NULL)
    {
        sscanf(buf, "%d %lg %lg %d", &id, &x, &y, &b);

        mesh->node[id].x = x;
        mesh->node[id].y = y;
        mesh->node[id].border = b;
        mesh->node[id].attrs = NULL;
    }

    fclose(fd);
}

void read_edges(mesh_t *mesh, char *filename)
{
    int id, n1, n2, b;
    int border;

    FILE *fd;
    char buf[MAXLINESIZE];

    fd = fopen(filename, "r");

    /* first read the 'header' */
    fscanf(fd, "%d %d", &(mesh->nb_edges), &border);

    mesh->edge = (edge_t *)malloc(sizeof(edge_t) * mesh->nb_edges);

    /* NOTE: does the border field only exist if the initial border flag is 1? */

    /* TODO: this reading thing needs to be made more robust, probably not
     * necessary for this exercise though.
     */
    while(fgets(buf, MAXLINESIZE, fd) != NULL)
    {
        sscanf(buf, "%d %d %d %d", &id, &n1, &n2, &b);

        mesh->edge[id].up = &(mesh->node[n1]);
        mesh->edge[id].down = &(mesh->node[n2]);
        mesh->edge[id].length = edge_length(mesh->edge[id]);
        mesh->edge[id].border = b;
    }

    fclose(fd);
}

void read_cells(mesh_t *mesh, char *filename)
{
    int id, n1, n2, n3;
    int nb_attr, nb_nodes;

    FILE *fd;
    char buf[MAXLINESIZE];
    int i;

    fd = fopen(filename, "r");

    /* first read the 'header' */
    fscanf(fd, "%d %d %d", &(mesh->nb_cells), &nb_nodes, &nb_attr);

    mesh->cell = (cell_t *)malloc(sizeof(cell_t) * mesh->nb_cells);

    /* TODO: get list of edges as well */
    while(fgets(buf, MAXLINESIZE, fd) != NULL)
    {
        sscanf(buf, "%d %d %d %d", &id, &n1, &n2, &n3);
        mesh->cell[id].node = (node_t **)malloc(sizeof(node_t *) * nb_nodes);

        mesh->cell[id].node[0] = &(mesh->node[n1]);
        mesh->cell[id].node[1] = &(mesh->node[n2]);
        mesh->cell[id].node[2] = &(mesh->node[n3]);
        mesh->cell[id].edge = NULL;
        mesh->cell[id].nb_nodes = nb_nodes;
        mesh->cell[id].area = cell_area(mesh->cell[id]);
    }

    fclose(fd);
}

/*
 *
 * FUNCTIONS DEFINED IN THE HEADER
 *
 */
mesh_t *init_mesh()
{
    mesh_t *mesh;
    mesh = (mesh_t *)malloc(sizeof *mesh);

    mesh->dim = 2;
    mesh->nb_nodes = 0;
    mesh->nb_edges = 0;
    mesh->nb_cells = 0;
    mesh->node = NULL;
    mesh->edge = NULL;
    mesh->cell = NULL;

    return mesh;
}

void free_mesh(mesh_t *mesh)
{
    /* TODO */
}

void read_data(mesh_t *mesh, char *file_basename)
{
    /* length is: basename + .1.extension (always 6 or 7 chars) + '\0' */
    int len = strlen(file_basename) + strlen(".1.extn") + 1;
    char *tmpfile;
    tmpfile = (char *)malloc(sizeof(char) * len);

    /* NOTE: any reason to use strncpy and strncat here? */
    /* First we read all the nodes because they're small */
    strcpy(tmpfile, file_basename);
    strcat(tmpfile, ".1.node");
    read_nodes(mesh, tmpfile);

    /* Then all the edges because we need the nodes to form edges */
    strcpy(tmpfile, file_basename);
    strcat(tmpfile, ".1.edge");
    read_edges(mesh, tmpfile);

    /* Stupid interdependecies */
    strcpy(tmpfile, file_basename);
    strcat(tmpfile, ".1.ele");
    read_cells(mesh, tmpfile);

    /* over! */
    free(tmpfile);
}

void write_data_to_vtk(mesh_t *mesh, char *dstFile)
{
    /* TODO */
}