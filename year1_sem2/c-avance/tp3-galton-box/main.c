#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static struct globals {
    /* number of discrete points */
    int NX;
    /* number of particles dancing around */
    int NBPARTICLES;
    /* interval start */
    double XMIN;
    /* interval end */
    double XMAX;
    /* time limit */
    double TMAX;
    /* time step = space step squared */
    double DELTAT;
    /* space step = (XMAX  - XMIN) / NX */
    double DELTAX;
    /* particle mass = 1 / NBPARTICLES */
    double PARTICLE_MASS;
} global;

/*
 * Initialize all global variables to some predefined values.
 * */
void init_globals(void)
{
    global.XMIN = -1;
    global.XMAX = 1;
    global.NX = 500;
    global.NBPARTICLES = 50e+5;
    global.TMAX = 3e-3;
    global.DELTAX = (global.XMAX - global.XMIN) / (2 * global.NX);
    global.DELTAT = global.DELTAX * global.DELTAX;
    global.PARTICLE_MASS = 1.0 / global.NBPARTICLES;
}

/*
 * Initialize the particles to the default position
 * */
double* init_positions(void)
{
    double *positions;
    int i;

    positions = malloc(global.NBPARTICLES * sizeof(double));
    for(i = 0; i < global.NBPARTICLES; i++) positions[i] = 0.0;

    return positions;
}

/*
 * Randomly go in some direction
 * */
double change_position(void)
{
    if(((double)rand() / RAND_MAX) < 0.5)
        return global.DELTAX;
    else
        return -global.DELTAX;
}

int main(void)
{
    init_globals();
    srand(time(NULL));

    double *particle_pos = init_positions();
    double time_it;
    int i;
    int *intervals;

    intervals = malloc((2 * global.NX + 1) * sizeof(int));

    /* while advancing in time */
    for(time_it = 0.0; time_it < global.TMAX; time_it += global.DELTAT)
    {
        /* our particles are moving around and having fun */
        for(i = 0; i < global.NBPARTICLES; i++)
        {
            /* nobody knows where the next position will be */
            particle_pos[i] += change_position();

            /* but it surely won't be outside of the playing area */
            if(particle_pos[i] < global.XMIN)
                particle_pos[i] = global.XMAX;

            if(particle_pos[i] > global.XMAX)
                particle_pos[i] = global.XMIN;
        }

        printf("# t=%g / TMAX = %g\n",time_it , global.TMAX);
    }

    /* reset intervals */
    for(i = 0; i < 2 * global.NX + 1; i++) intervals[i] = 0;

    /* determine the number of particles in each interval */
    for(i = 0; i < global.NBPARTICLES; i++)
    {
        /* each x_i = XMIN + i * DELTAX so to find i we solve that */
        int j = (int)((particle_pos[i] - global.XMIN ) / global.DELTAX);
        ++intervals[j];
    }

    for(i = 0; i < 2 * global.NX; i++)
    {
        /* middle of the interval (x_n + x_{n + 1}) / 2 */
        double interval_i = 2 * global.XMIN + (2 * i + 1) * global.DELTAX;
        /* mass of all particles in the interval */
        double mass = intervals[i] * global.PARTICLE_MASS;
        printf("%g %g\n", interval_i / 2, mass);
    }

    return 0;
}
