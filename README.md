# rspec-mocks failure example
Related to https://github.com/rspec/rspec-mocks/issues/1499

Upgrading from rspec-mocks v3.11.1 to v3.11.2 or v3.12.0 seems to cause some issues with the `receive` matcher (or related).

You'll see in spec/lib/analytics_service_spec.rb there are two examples. They do very similar things, but one will always fail when not using the `.receive()` block form. When we call `.receive(...).with(...)` it will always fail. But replacing that with `.receive(...) do |arg|` will make it pass.

# How to test

```shell
bin/rspec
```

Then you'll see these two examples; one passes, one fails:

```
AnalyticsService
  .track
    does not fail when I use .receive().with() (FAILED - 1)
    does not fail when I use .receive() block-form

Failures:

  1) AnalyticsService.track does not fail when I use .receive().with()
     Failure/Error: tracker.track(payload)

       #<Tracker:0x0000000107ddf510> received :track with unexpected arguments
         expected: ({:anonymous_id=>nil, :event=>"foobar", :properties=>{:deployment_type=>"standard", :fake_property=>"f...9}, :timestamp=>#<DateTime: 2020-01-01T00:00:00+00:00 ((2458850j,0s,0n),+0s,2299161j)>, :user_id=>1}) (keyword arguments)
              got: ({:anonymous_id=>nil, :event=>"foobar", :properties=>{:deployment_type=>"standard", :fake_property=>"f...9}, :timestamp=>#<DateTime: 2020-01-01T00:00:00+00:00 ((2458850j,0s,0n),+0s,2299161j)>, :user_id=>1}) (options hash)
       Diff:

     # ./lib/analytics_service.rb:26:in `track'
     # ./spec/lib/analytics_service_spec.rb:31:in `block (3 levels) in <top (required)>'

Finished in 0.03275 seconds (files took 0.15496 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/lib/analytics_service_spec.rb:23 # AnalyticsService.track does not fail when I use .receive().with()
```
