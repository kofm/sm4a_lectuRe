library(lubridate)

sim_out <- 
  read.csv("GenericModelOutputs_thermalLimit.csv")
sim_out

sim_out$Date <- as.Date(sim_out$Date, format = "%m/%d/%Y")

weather_summary <- 
  sim_out %>% 
  mutate(year = year(Date), month = month(Date),
         tave = (Tmax + Tmin)/2) %>% 
  group_by(year, month, Location) %>% 
  summarise(
    tave = mean(tave),
    tmax = max(Tmax),
    tmix = min(Tmin)
    )

yield <- 
  sim_out %>% 
  mutate(year = year(Date), month = month(Date),
         tave = (Tmax + Tmin)/2) %>% 
  group_by(Location, year) %>% 
  summarise(yield = max(Yield)) %>% 
  mutate(yield = yield / 1000)

# Grouping and summarising data
agb_rate <- 
  sim_out %>% 
  select(Location, Date, Doy, AGBrate) %>% 
  group_by(Location, Doy) %>% 
  summarise(AGBrate = mean(AGBrate))

ggplot(agb_rate) +
  aes(x = Doy, y = AGBrate, color = Location) +
  geom_path() +
  facet_wrap(~ Location)
# Visualizing data

# Linear Models on data