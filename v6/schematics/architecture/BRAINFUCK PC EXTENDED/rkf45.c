/*
   ============================================================
   Изменение ТОЛЬКО вывода:
   - mpfr_printf вызывается раз в 1000 шагов
   Остальной код не изменён
   ============================================================
*/

#include <stdio.h>
#include <time.h>
#include <mpfr.h>

#define PREC 1024
#define NEQ 2
#define STAGES 6

typedef struct
{
    mpfr_t mu;
    mpfr_t term1;
} rhs_workspace_t;

void set_fraction(mpfr_t x, long num, long den)
{
    mpfr_set_si(x, num, MPFR_RNDN);
    mpfr_div_si(x, x, den, MPFR_RNDN);
}

void rhs_workspace_init(rhs_workspace_t *ws)
{
    mpfr_init2(ws->mu, PREC);
    mpfr_init2(ws->term1, PREC);
    mpfr_set_si(ws->mu, 100000, MPFR_RNDN);
}

void rhs_workspace_clear(rhs_workspace_t *ws)
{
    mpfr_clear(ws->mu);
    mpfr_clear(ws->term1);
}

void f(mpfr_t result[NEQ], const mpfr_t t, mpfr_t y[NEQ], rhs_workspace_t *ws)
{
    (void)t;

    mpfr_set(result[0], y[1], MPFR_RNDN);

    mpfr_mul(ws->term1, y[0], y[0], MPFR_RNDN);
    mpfr_ui_sub(ws->term1, 1, ws->term1, MPFR_RNDN);
    mpfr_mul(ws->term1, ws->term1, ws->mu, MPFR_RNDN);
    mpfr_mul(ws->term1, ws->term1, y[1], MPFR_RNDN);
    mpfr_sub(result[1], ws->term1, y[0], MPFR_RNDN);
}

void calc_step_vec(mpfr_t dest[NEQ], mpfr_t y[NEQ], mpfr_t coeffs[], mpfr_t ks[STAGES][NEQ], int count)
{
    mpfr_t term;
    mpfr_init2(term, PREC);

    for (int j = 0; j < NEQ; j++)
    {
        mpfr_set(dest[j], y[j], MPFR_RNDN);

        for (int i = 0; i < count; i++)
        {
            mpfr_mul(term, coeffs[i], ks[i][j], MPFR_RNDN);
            mpfr_add(dest[j], dest[j], term, MPFR_RNDN);
        }
    }

    mpfr_clear(term);
}

int main()
{
    struct timespec start_time, end_time;
    clock_gettime(CLOCK_MONOTONIC, &start_time);

    mpfr_t t, h, t_end, atol, rtol, error, max_err, scale, ratio, s, tmp_t, h_min;

    mpfr_inits2(PREC,
        t, h, t_end, atol, rtol, error, max_err, scale, ratio, s, tmp_t, h_min,
        NULL);

    mpfr_t safety, four, one_tenth;
    mpfr_inits2(PREC, safety, four, one_tenth, NULL);

    mpfr_set_str(safety, "0.84", 10, MPFR_RNDN);
    mpfr_set_ui(four, 4, MPFR_RNDN);
    set_fraction(one_tenth, 1, 10);

    mpfr_t y[NEQ], y4[NEQ], y5[NEQ], tmp_y[NEQ];
    for (int i = 0; i < NEQ; i++)
    {
        mpfr_init2(y[i], PREC);
        mpfr_init2(y4[i], PREC);
        mpfr_init2(y5[i], PREC);
        mpfr_init2(tmp_y[i], PREC);
    }

    mpfr_t ks[STAGES][NEQ];
    for (int i = 0; i < STAGES; i++)
        for (int j = 0; j < NEQ; j++)
            mpfr_init2(ks[i][j], PREC);

    mpfr_t c3[2], c4[3], c5[4], c6[5], b4[6], b5[6];

    for (int i = 0; i < 2; i++) mpfr_init2(c3[i], PREC);
    for (int i = 0; i < 3; i++) mpfr_init2(c4[i], PREC);
    for (int i = 0; i < 4; i++) mpfr_init2(c5[i], PREC);
    for (int i = 0; i < 5; i++) mpfr_init2(c6[i], PREC);
    for (int i = 0; i < 6; i++)
    {
        mpfr_init2(b4[i], PREC);
        mpfr_init2(b5[i], PREC);
    }

    set_fraction(c3[0], 3, 32);
    set_fraction(c3[1], 9, 32);

    set_fraction(c4[0], 1932, 2197);
    set_fraction(c4[1], -7200, 2197);
    set_fraction(c4[2], 7296, 2197);

    set_fraction(c5[0], 439, 216);
    mpfr_set_si(c5[1], -8, MPFR_RNDN);
    set_fraction(c5[2], 3680, 513);
    set_fraction(c5[3], -845, 4104);

    set_fraction(c6[0], -8, 27);
    mpfr_set_si(c6[1], 2, MPFR_RNDN);
    set_fraction(c6[2], -3544, 2565);
    set_fraction(c6[3], 1859, 4104);
    set_fraction(c6[4], -11, 40);

    set_fraction(b4[0], 25, 216);
    mpfr_set_zero(b4[1], 0);
    set_fraction(b4[2], 1408, 2565);
    set_fraction(b4[3], 2197, 4104);
    set_fraction(b4[4], -1, 5);
    mpfr_set_zero(b4[5], 0);

    set_fraction(b5[0], 16, 135);
    mpfr_set_zero(b5[1], 0);
    set_fraction(b5[2], 6656, 12825);
    set_fraction(b5[3], 28561, 56430);
    set_fraction(b5[4], -9, 50);
    set_fraction(b5[5], 2, 55);

    rhs_workspace_t rhs_ws;
    rhs_workspace_init(&rhs_ws);

    mpfr_set_ui(t, 0, MPFR_RNDN);
    mpfr_set_si(y[0], 2, MPFR_RNDN);
    mpfr_set_ui(y[1], 0, MPFR_RNDN);

    mpfr_set_str(h, "1e-3", 10, MPFR_RNDN);
    mpfr_set_ui(t_end, 20, MPFR_RNDN);

    mpfr_set_str(atol, "1e-25", 10, MPFR_RNDN);
    mpfr_set_str(rtol, "1e-25", 10, MPFR_RNDN);
    mpfr_set_str(h_min, "1e-50", 10, MPFR_RNDN);

    unsigned long accepted_steps = 0;
    unsigned long rejected_steps = 0;

    printf("%-12s %-35s %-35s %-20s\n", "t", "y1", "y2", "h");

    while (mpfr_cmp(t, t_end) < 0)
    {
        mpfr_add(tmp_t, t, h, MPFR_RNDN);

        if (mpfr_cmp(tmp_t, t_end) > 0)
            mpfr_sub(h, t_end, t, MPFR_RNDN);

        f(ks[0], t, y, &rhs_ws);
        for (int j = 0; j < NEQ; j++)
            mpfr_mul(ks[0][j], ks[0][j], h, MPFR_RNDN);

        mpfr_add(tmp_t, t, h, MPFR_RNDN);
        for (int j = 0; j < NEQ; j++)
        {
            mpfr_div_ui(tmp_y[j], ks[0][j], 4, MPFR_RNDN);
            mpfr_add(tmp_y[j], tmp_y[j], y[j], MPFR_RNDN);
        }

        f(ks[1], tmp_t, tmp_y, &rhs_ws);
        for (int j = 0; j < NEQ; j++)
            mpfr_mul(ks[1][j], ks[1][j], h, MPFR_RNDN);

        calc_step_vec(tmp_y, y, c3, ks, 2);
        f(ks[2], tmp_t, tmp_y, &rhs_ws);
        for (int j = 0; j < NEQ; j++)
            mpfr_mul(ks[2][j], ks[2][j], h, MPFR_RNDN);

        calc_step_vec(tmp_y, y, c4, ks, 3);
        f(ks[3], tmp_t, tmp_y, &rhs_ws);
        for (int j = 0; j < NEQ; j++)
            mpfr_mul(ks[3][j], ks[3][j], h, MPFR_RNDN);

        calc_step_vec(tmp_y, y, c5, ks, 4);
        f(ks[4], tmp_t, tmp_y, &rhs_ws);
        for (int j = 0; j < NEQ; j++)
            mpfr_mul(ks[4][j], ks[4][j], h, MPFR_RNDN);

        calc_step_vec(tmp_y, y, c6, ks, 5);
        f(ks[5], tmp_t, tmp_y, &rhs_ws);
        for (int j = 0; j < NEQ; j++)
            mpfr_mul(ks[5][j], ks[5][j], h, MPFR_RNDN);

        calc_step_vec(y4, y, b4, ks, 6);
        calc_step_vec(y5, y, b5, ks, 6);

        mpfr_set_zero(max_err, 1);

        for (int j = 0; j < NEQ; j++)
        {
            mpfr_sub(error, y5[j], y4[j], MPFR_RNDN);
            mpfr_abs(error, error, MPFR_RNDN);

            mpfr_abs(scale, y5[j], MPFR_RNDN);
            mpfr_mul(scale, scale, rtol, MPFR_RNDN);
            mpfr_add(scale, scale, atol, MPFR_RNDN);

            mpfr_div(error, error, scale, MPFR_RNDN);

            if (mpfr_cmp(error, max_err) > 0)
                mpfr_set(max_err, error, MPFR_RNDN);
        }

        if (mpfr_cmp_ui(max_err, 1) <= 0)
        {
            for (int j = 0; j < NEQ; j++)
                mpfr_set(y[j], y5[j], MPFR_RNDN);

            mpfr_add(t, t, h, MPFR_RNDN);
            accepted_steps++;

            /* ====== ИЗМЕНЕНИЕ ТОЛЬКО ЗДЕСЬ ====== */
            if (accepted_steps % 1000 == 0)
            {
                mpfr_printf(
                    "%-12.6Rf %-35.20Rf %-35.20Rf %-20.5Re\n",
                    t, y[0], y[1], h
                );
            }
        }
        else
        {
            rejected_steps++;
        }

        if (mpfr_cmp_ui(max_err, 0) > 0)
        {
            mpfr_ui_div(ratio, 1, max_err, MPFR_RNDN);
            mpfr_sqrt(s, ratio, MPFR_RNDN);
            mpfr_sqrt(s, s, MPFR_RNDN);
            mpfr_mul(s, s, safety, MPFR_RNDN);

            if (mpfr_cmp(s, four) > 0)
                mpfr_set(s, four, MPFR_RNDN);

            if (mpfr_cmp(s, one_tenth) < 0)
                mpfr_set(s, one_tenth, MPFR_RNDN);

            mpfr_mul(h, h, s, MPFR_RNDN);
        }
        else
        {
            mpfr_mul_ui(h, h, 2, MPFR_RNDN);
        }

        if (mpfr_cmp(h, h_min) < 0)
        {
            printf("\nERROR: step underflow.\n");
            break;
        }
    }

    printf("\nAccepted steps : %lu\n", accepted_steps);
    printf("Rejected steps : %lu\n", rejected_steps);

    clock_gettime(CLOCK_MONOTONIC, &end_time);

    double elapsed =
        (end_time.tv_sec - start_time.tv_sec) +
        (end_time.tv_nsec - start_time.tv_nsec) * 1e-9;

    printf("Execution time : %.9f seconds\n", elapsed);

    rhs_workspace_clear(&rhs_ws);
    mpfr_free_cache();
	
	printf("\nPress Enter to exit...\n");
	getchar();

    return 0;
}